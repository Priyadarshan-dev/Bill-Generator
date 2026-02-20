import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bill_data.dart';
import '../services/pdf_service.dart';
import '../widgets/billed_to_field.dart';
import '../widgets/date_selector.dart';
import '../widgets/service_item_card.dart';
import '../widgets/generate_bill_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _billedToController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final List<ServiceItem> _services = [
    ServiceItem(service: '', count: 1, amountPerLoad: 0),
  ];

  void _addService() {
    setState(() {
      _services.add(ServiceItem(service: '', count: 1, amountPerLoad: 0));
    });
  }

  void _removeService(int index) {
    setState(() {
      if (_services.length > 1) {
        _services.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Bill Generator',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bill Details",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(color: Colors.grey.shade300),
              SizedBox(
                height: 235,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Details",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      BilledToField(
                        controller: _billedToController,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DateSelector(
                        selectedDate: _selectedDate,
                        onDateSelected: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                'Services',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(color: Colors.grey.shade300),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  return ServiceItemCard(
                    service: _services[index],
                    index: index,
                    onRemove: () => _removeService(index),
                    onAdd: _addService,
                    onNameChanged: (value) => _services[index].service = value,
                    onCountChanged: (value) => _services[index].count = value,
                    onAmountChanged: (value) =>
                        _services[index].amountPerLoad = value,
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: GenerateBillButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final billData = BillData(
                billedTo: _billedToController.text,
                date: _selectedDate,
                services: _services,
              );

              await PdfService.generateAndPreview(context, billData);
            }
          },
        ),
      ),
    );
  }
}
