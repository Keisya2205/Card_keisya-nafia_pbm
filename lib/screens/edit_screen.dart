import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

import '../services/supabase_service.dart';
import 'result_screen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() =>
      _EditScreenState();
}

class _EditScreenState
    extends State<EditScreen> {

  Uint8List? imageBytes;

  final picker = ImagePicker();

  final screenshotController =
      ScreenshotController();

  final nameController =
      TextEditingController();

  final quoteController =
      TextEditingController();

  bool isLoading = false;

  // =========================
  // PICK IMAGE
  // =========================
  Future pickImage() async {

    final picked =
        await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {

      final bytes =
          await picked.readAsBytes();

      setState(() {

        imageBytes = bytes;
      });
    }
  }

  // =========================
  // SAVE CARD
  // =========================
  Future saveCard() async {

    if (imageBytes == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Upload foto dulu ❤️',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      // screenshot card
      final image =
          await screenshotController
              .capture();

      if (image == null) return;

      // upload to supabase
      await SupabaseService
          .uploadCard(

        imageBytes: image,

        name:
            nameController.text,

        quote:
            quoteController.text,
      );

      if (!mounted) return;

      // pindah ke result
      Navigator.push(

         context,

        MaterialPageRoute(
           builder: (_) =>
               ResultScreen(

             imageBytes: image,

              name: nameController.text,

             quote: quoteController.text,
           ),
          ), 
        );
      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Card berhasil dibuat ❤️',
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(
            'Error: $e',
          ),
        ),
      );

    } finally {

      setState(() {

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF7F2FF),

      appBar: AppBar(

        backgroundColor:
            Colors.transparent,

        elevation: 0,

        title: const Text(

          'Create Card',

          style: TextStyle(

            color: Colors.black,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            // =====================
            // CARD PREVIEW
            // =====================
            Screenshot(

              controller:
                  screenshotController,

              child: Container(

                width: 320,

                padding:
                    const EdgeInsets.all(
                        20),

                decoration: BoxDecoration(

                  borderRadius:
                      BorderRadius.circular(
                          30),

                  gradient:
                      const LinearGradient(

                    begin:
                        Alignment.topLeft,

                    end:
                        Alignment.bottomRight,

                    colors: [

                      Color(0xffFFB5E8),

                      Color(0xffB5D8FF),
                    ],
                  ),

                  boxShadow: [

                    BoxShadow(

                      color:
                          Colors.black12,

                      blurRadius: 10,

                      offset:
                          Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(

                  mainAxisSize:
                      MainAxisSize.min,

                  children: [

                    CircleAvatar(

                      radius: 70,

                      backgroundColor:
                          Colors.white,

                      backgroundImage:
                          imageBytes != null

                              ? MemoryImage(
                                  imageBytes!,
                                )

                              : null,

                      child:
                          imageBytes == null

                              ? const Icon(

                                  Icons.person,

                                  size: 60,

                                  color:
                                      Colors.grey,
                                )

                              : null,
                    ),

                    const SizedBox(
                        height: 20),

                    Text(

                      nameController
                              .text.isEmpty

                          ? 'Your Name'

                          : nameController
                              .text,

                      textAlign:
                          TextAlign.center,

                      style:
                          const TextStyle(

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(

                      quoteController
                              .text.isEmpty

                          ? 'your cute quote ✨'

                          : quoteController
                              .text,

                      textAlign:
                          TextAlign.center,

                      style:
                          const TextStyle(

                        color:
                            Colors.white,

                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =====================
            // UPLOAD BUTTON
            // =====================
            SizedBox(

              width: double.infinity,

              child:
                  ElevatedButton.icon(

                onPressed:
                    pickImage,

                icon: const Icon(
                  Icons.upload,
                ),

                label: const Text(
                  'Upload Foto',
                ),

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                          0xffB5D8FF),

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets
                          .symmetric(
                    vertical: 18,
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =====================
            // NAME INPUT
            // =====================
            TextField(

              controller:
                  nameController,

              onChanged: (_) {

                setState(() {});
              },

              decoration:
                  InputDecoration(

                hintText:
                    'Input Name',

                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          20),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // =====================
            // QUOTE INPUT
            // =====================
            TextField(

              controller:
                  quoteController,

              onChanged: (_) {

                setState(() {});
              },

              maxLines: 3,

              decoration:
                  InputDecoration(

                hintText:
                    'Input Quote',

                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                          20),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =====================
            // SAVE BUTTON
            // =====================
            SizedBox(

              width: double.infinity,

              child:
                  ElevatedButton.icon(

                onPressed:
                    isLoading

                        ? null

                        : saveCard,

                icon:
                    isLoading

                        ? const SizedBox(

                            width: 20,
                            height: 20,

                            child:
                                CircularProgressIndicator(

                              color:
                                  Colors.white,

                              strokeWidth: 2,
                            ),
                          )

                        : const Icon(
                            Icons.save,
                          ),

                label: Text(

                  isLoading

                      ? 'Uploading...'

                      : 'Save Card',
                ),

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                          0xffFFB5E8),

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets
                          .symmetric(
                    vertical: 18,
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}