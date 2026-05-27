import 'package:flutter/material.dart';

import 'edit_screen.dart';
import 'gallery_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF7F2FF),

      appBar: AppBar(

        backgroundColor:
            Colors.transparent,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          'Cute Card ✨',
          style: TextStyle(
            color: Colors.black,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        actions: [

          IconButton(

            onPressed: () {

              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                      const GalleryScreen(),
                ),
              );
            },

            icon: const Icon(
              Icons.photo,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            Container(

              width: double.infinity,

              padding:
                  const EdgeInsets.all(25),

              decoration: BoxDecoration(

                borderRadius:
                    BorderRadius.circular(
                        30),

                gradient:
                    const LinearGradient(

                  colors: [
                    Color(0xffFFB5E8),
                    Color(0xffB5D8FF),
                  ],
                ),
              ),

              child: const Column(

                children: [

                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 50,
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Create Your Cute Card 💕',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(

              width: double.infinity,

              child:
                  ElevatedButton.icon(

                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          const EditScreen(),
                    ),
                  );
                },

                icon:
                    const Icon(Icons.edit),

                label: const Text(
                  'Create Card',
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