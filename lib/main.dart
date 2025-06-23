import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url:
        'https://ycvlfkiccuvahqvgtqrq.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inljdmxma2ljY3V2YWhxdmd0cXJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA0OTkyNjQsImV4cCI6MjA2NjA3NTI2NH0.uOUdDU4Du4SgXP1B83FI6xkWloxYFH-RNrk118nuHGM', // Replace with your anon key
  );
  runApp(const RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check Dream Property',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6B00), // Orange
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromRGBO(239, 131, 23, 1),
          secondary: const Color(0xFF333333),
          background: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}
