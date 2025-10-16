import 'package:flutter/material.dart';

import 'package:zerodha_clone/screens/buy.dart';

final ThemeData kiteLikeTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(
    0xFF2962FF,
  ), // Bright blue for actions (e.g., "Swipe to Buy")
  scaffoldBackgroundColor: const Color(0xFFF9FAFB), // Light neutral background
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    iconTheme: IconThemeData(color: Colors.black87),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
    bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
    labelLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF2962FF)),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(const Color(0xFF2962FF)),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return const Color(0x332962FF);
      return const Color(0xFFE0E0E0);
    }),
  ),
  cardColor: Colors.white,
  shadowColor: Colors.black12,
  dividerColor: const Color(0xFFE0E0E0),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoroddh kite',
      theme: kiteLikeTheme,
      home: BuyScreen(),
    );
  }
}
