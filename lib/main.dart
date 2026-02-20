import 'package:flutter/material.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  runApp(const BillGeneratorApp());
}

class BillGeneratorApp extends StatelessWidget {
  const BillGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
        fontFamily: 'Roboto', // Fallback font
      ),
      home: const HomeScreen(),
    );
  }
}
