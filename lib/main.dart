import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://expiojugfqdoizfiwbwr.supabase.co',

    anonKey:
        'sb_publishable_1aBYS-vWNuu39p4g6BmUeA_RfVY5Aya',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false,

      title: 'Cute Card',

      theme: ThemeData(
        fontFamily: 'Poppins',
      ),

      home: const HomeScreen(),
    );
  }
}