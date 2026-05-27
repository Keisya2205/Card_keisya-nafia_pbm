import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {

  static final supabase =
      Supabase.instance.client;

  // UPLOAD CARD
  static Future<void> uploadCard({

    required Uint8List imageBytes,
    required String name,
    required String quote,

  }) async {

    final fileName =
        'card_${DateTime.now().millisecondsSinceEpoch}.png';

    // upload image
    await supabase.storage
        .from('photo-result')
        .uploadBinary(
          fileName,
          imageBytes,
        );

    // get public url
    final imageUrl =
        supabase.storage
            .from('photo-result')
            .getPublicUrl(fileName);

    // save data to table
    await supabase
        .from('cards')
        .insert({

      'image_url': imageUrl,
      'name': name,
      'quote': quote,

    });
  }

  // GET CARDS
  static Future<List<dynamic>>
      getCards() async {

    final data = await supabase
        .from('cards')
        .select()
        .order('created_at');

    return data;
  }

  // DELETE CARD
  static Future deleteCard(
      int id) async {

    await supabase
        .from('cards')
        .delete()
        .eq('id', id);
  }
}