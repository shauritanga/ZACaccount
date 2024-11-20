import 'package:intl/intl.dart';

List<Map<String, dynamic>> getInvoicesThisWeek(
    List<Map<String, dynamic>> invoices) {
  // Get the current date and calculate the start of the week (Monday) and the end of the week (Sunday)
  DateTime now = DateTime.now();
  int daysToSubtract = now.weekday - 1;
  DateTime startOfWeek =
      now.subtract(Duration(days: daysToSubtract)).startOfDay;
  DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)).endOfDay;

  // Convert start and end of the week to string for easy comparison
  String startOfWeekStr = DateFormat('yyyy-MM-dd').format(startOfWeek);
  String endOfWeekStr = DateFormat('yyyy-MM-dd').format(endOfWeek);

  // Filter invoices by comparing the createdAt date
  return invoices.where((invoice) {
    // Parse the createdAt field as DateTime
    DateTime createdAt = DateTime.parse(invoice['invoiceDate']);

    // Format the createdAt date as yyyy-MM-dd
    String invoiceDate = DateFormat('yyyy-MM-dd').format(createdAt);

    // Check if the invoice date is within this week
    return invoiceDate.compareTo(startOfWeekStr) >= 0 &&
        invoiceDate.compareTo(endOfWeekStr) <= 0;
  }).toList();
}

extension on DateTime {
  // Get the start of the day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  // Get the end of the day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}
