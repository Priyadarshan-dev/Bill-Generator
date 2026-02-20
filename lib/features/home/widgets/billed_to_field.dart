import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BilledToField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const BilledToField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Billed To',
          labelStyle: GoogleFonts.poppins(color: Colors.grey.shade800),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
