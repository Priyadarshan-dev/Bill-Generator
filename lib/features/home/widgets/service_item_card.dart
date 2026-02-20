import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bill_data.dart';

class ServiceItemCard extends StatelessWidget {
  final ServiceItem service;
  final int index;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<int> onCountChanged;
  final ValueChanged<double> onAmountChanged;

  const ServiceItemCard({
    super.key,
    required this.service,
    required this.index,
    required this.onRemove,
    required this.onAdd,
    required this.onNameChanged,
    required this.onCountChanged,
    required this.onAmountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Service Details",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  initialValue: service.service,
                  decoration: InputDecoration(
                    labelText: 'Service Name',
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.grey.shade800,
                    ),
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
                  onChanged: onNameChanged,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter service name'
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Count',
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.grey.shade800,
                    ),
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      onCountChanged(int.tryParse(value) ?? 0),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter count';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return 'Enter a valid count';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount per Load',
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.grey.shade800,
                    ),
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      onAmountChanged(double.tryParse(value) ?? 0),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter amount';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) <= 0) {
                      return 'Enter a valid amount';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: onAdd,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade900,
                          foregroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add, color: Colors.white),
                            Text(
                              "Add Service",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: onRemove,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade900,
                          foregroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Remove Service",
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
