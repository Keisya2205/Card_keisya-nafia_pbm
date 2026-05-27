import 'package:flutter/material.dart';

import '../services/supabase_service.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() =>
      _GalleryScreenState();
}

class _GalleryScreenState
    extends State<GalleryScreen> {

  List cards = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future loadCards() async {

    final result =
        await SupabaseService
            .getCards();

    setState(() {

      cards = result;

      isLoading = false;
    });
  }

  Future deleteCard(int id) async {

    await SupabaseService
        .deleteCard(id);

    loadCards();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xffF3EEF8),

      appBar: AppBar(

        backgroundColor:
            const Color(0xffD9D2E9),

        elevation: 0,

        title: const Text(

          'Gallery',

          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : cards.isEmpty

              ? const Center(
                  child: Text(
                    'Belum ada card ❤️',
                  ),
                )

              : GridView.builder(

                  padding:
                      const EdgeInsets.all(
                          20),

                  itemCount:
                      cards.length,

                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 2,

                    crossAxisSpacing:
                        20,

                    mainAxisSpacing:
                        20,

                    childAspectRatio:
                        0.75,
                  ),

                  itemBuilder:
                      (context, index) {

                    final card =
                        cards[index];

                    return Stack(

                      children: [

                        Container(

                          decoration:
                              BoxDecoration(

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        28),

                            gradient:
                                const LinearGradient(

                              colors: [

                                Color(
                                    0xffFFB5E8),

                                Color(
                                    0xffB5D8FF),
                              ],

                              begin:
                                  Alignment
                                      .topLeft,

                              end:
                                  Alignment
                                      .bottomRight,
                            ),

                            boxShadow: [

                              BoxShadow(

                                color:
                                    Colors.black12,

                                blurRadius:
                                    10,

                                offset:
                                    const Offset(
                                        0,
                                        5),
                              ),
                            ],
                          ),

                          child: Padding(

                            padding:
                                const EdgeInsets
                                    .all(20),

                            child: Column(

                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                              children: [

                                CircleAvatar(

                                  radius: 50,

                                  backgroundImage:
                                      NetworkImage(
                                    card[
                                        'image_url'],
                                  ),
                                ),

                                const SizedBox(
                                    height: 18),

                                Text(

                                  card['name'] ??
                                      '',

                                  textAlign:
                                      TextAlign
                                          .center,

                                  style:
                                      const TextStyle(

                                    color:
                                        Colors.white,

                                    fontSize: 22,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(
                                    height: 8),

                                Text(

                                  card['quote'] ??
                                      '',

                                  textAlign:
                                      TextAlign
                                          .center,

                                  style:
                                      const TextStyle(

                                    color:
                                        Colors.white70,

                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Positioned(

                          top: 10,

                          right: 10,

                          child:
                              GestureDetector(

                            onTap: () {

                              deleteCard(
                                card['id'],
                              );
                            },

                            child: Container(

                              padding:
                                  const EdgeInsets
                                      .all(8),

                              decoration:
                                  const BoxDecoration(

                                color:
                                    Colors.white,

                                shape:
                                    BoxShape.circle,
                              ),

                              child: const Icon(

                                Icons.delete,

                                color:
                                    Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}