import 'package:intl/intl.dart';

List<Map<String, dynamic>> getInvoicesThisMonth(
    List<Map<String, dynamic>> invoices) {
  // Get the current date
  DateTime now = DateTime.now();

  // Get the first day of the current month (1st day of the month)
  DateTime startOfMonth = DateTime(now.year, now.month, 1).startOfDay;

  // Get the last day of the current month (the last day of the month)
  DateTime endOfMonth = DateTime(now.year, now.month + 1, 0).endOfDay;

  // Convert start and end of the month to string for easy comparison
  String startOfMonthStr = DateFormat('yyyy-MM-dd').format(startOfMonth);
  String endOfMonthStr = DateFormat('yyyy-MM-dd').format(endOfMonth);

  // Filter invoices by comparing the createdAt date
  return invoices.where((invoice) {
    // Parse the createdAt field as DateTime
    DateTime createdAt = DateTime.parse(invoice['invoiceDate']);

    // Format the createdAt date as yyyy-MM-dd
    String invoiceDate = DateFormat('yyyy-MM-dd').format(createdAt);

    // Check if the invoice date is within this month
    return invoiceDate.compareTo(startOfMonthStr) >= 0 &&
        invoiceDate.compareTo(endOfMonthStr) <= 0;
  }).toList();
}

extension on DateTime {
  // Get the start of the day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  // Get the end of the day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}
