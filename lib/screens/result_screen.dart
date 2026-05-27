import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'gallery_screen.dart';

class ResultScreen extends StatefulWidget {

  final Uint8List imageBytes;

  final String name;

  final String quote;

  const ResultScreen({

    super.key,

    required this.imageBytes,

    required this.name,

    required this.quote,
  });

  @override
  State<ResultScreen> createState() =>
      _ResultScreenState();
}

class _ResultScreenState
    extends State<ResultScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF7F2FF),

      appBar: AppBar(

        backgroundColor:
            Colors.transparent,

        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              // CARD
              Container(

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

                  boxShadow: const [

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

                  children: [

                    // PHOTO
                    CircleAvatar(

                      radius: 70,

                      backgroundColor:
                          Colors.white,

                      backgroundImage:
                          MemoryImage(
                        widget.imageBytes,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    // NAME
                    Text(

                      widget.name,

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

                    // QUOTE
                    Text(

                      widget.quote,

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

              const SizedBox(
                  height: 30),

              // BUTTON
              SizedBox(

                width: 220,

                height: 55,

                child: ElevatedButton(

                  onPressed: () {

                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            const GalleryScreen(),
                      ),
                    );
                  },

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(
                            0xffFFB5E8),

                    foregroundColor:
                        Colors.white,

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),
                  ),

                  child: const Text(

                    'Go To Gallery',

                    style: TextStyle(

                      fontSize: 16,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}