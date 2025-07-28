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
  scaffoldBackgroundColor: const Color(0xFFF2F2F2), // Light gray background
  cardColor: Colors.white, // Default card color
  useMaterial3: false, // Disable Material 3 for stronger shadows
  textTheme: GoogleFonts.poppinsTextTheme(),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFFF6B00), // Orange
    background: Colors.white,
    surface: Colors.white, // Most important for cards
    onSurface: Colors.black,
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 4,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    shadowColor: Colors.black.withOpacity(0.2), // Custom shadow
    surfaceTintColor: Colors.white, // Ensure no tint
  ),
),

      home: const HomePage(),
    );
  }
}
