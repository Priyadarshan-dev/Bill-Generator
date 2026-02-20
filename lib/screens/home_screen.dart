import 'package:flutter/material.dart';
import 'package:rrr_bill_generator/features/home/services/pdf_service.dart';
import '../features/home/models/bill_data.dart';

import 'package:intl/intl.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
        title: const Text('Bill Generator'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _billedToController,
                decoration: const InputDecoration(
                  labelText: 'Billed To',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter name' : null,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Service Name',
                                  ),
                                  onChanged: (value) =>
                                      _services[index].service = value,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.red,
                                ),
                                onPressed: () => _removeService(index),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Count',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => _services[index].count =
                                      int.tryParse(value) ?? 0,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Amount per load',
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) =>
                                      _services[index].amountPerLoad =
                                          double.tryParse(value) ?? 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _addService,
                icon: const Icon(Icons.add),
                label: const Text('Add Service'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    print('Generate button pressed');

                    if (_formKey.currentState!.validate()) {
                      print('Form validated');

                      final billData = BillData(
                        billedTo: _billedToController.text,
                        date: _selectedDate,
                        services: _services,
                      );

                      print('BillData created:');
                      print('Billed To: ${billData.billedTo}');
                      print('Date: ${billData.date}');
                      print('Services count: ${billData.services.length}');

                      await PdfService.generateAndPreview(context, billData);

                      print('PDF generation completed');
                    } else {
                      print('Form validation failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Generate & Preview PDF',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
