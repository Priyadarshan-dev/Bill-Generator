import 'package:intl/intl.dart';

class ServiceItem {
  String service;
  int count;
  double amountPerLoad;

  ServiceItem({
    required this.service,
    required this.count,
    required this.amountPerLoad,
  });

  double get total => count * amountPerLoad;
}

class BillData {
  String billedTo;
  DateTime date;
  List<ServiceItem> services;

  BillData({
    required this.billedTo,
    required this.date,
    required this.services,
  });

  double get totalAmount {
    return services.fold(0, (sum, item) => sum + item.total);
  }

  String get formattedDate => DateFormat('dd-MM-yyyy').format(date);
  String get formattedTotal => 'Rs. ${totalAmount.toInt()}';
}
