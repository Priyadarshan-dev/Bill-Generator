import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenerateBillButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GenerateBillButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.white,
          ),
          child: Text(
            'Generate & Preview PDF',
            style: GoogleFonts.poppins(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
