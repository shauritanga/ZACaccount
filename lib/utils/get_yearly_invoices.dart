import 'package:intl/intl.dart';

List<Map<String, dynamic>> getInvoicesThisYear(
    List<Map<String, dynamic>> invoices) {
  // Get the current date
  DateTime now = DateTime.now();

  // Get the first day of the current year (January 1st)
  DateTime startOfYear = DateTime(now.year, 1, 1).startOfDay;

  // Get the last day of the current year (December 31st)
  DateTime endOfYear = DateTime(now.year, 12, 31).endOfDay;

  // Convert start and end of the year to string for easy comparison
  String startOfYearStr = DateFormat('yyyy-MM-dd').format(startOfYear);
  String endOfYearStr = DateFormat('yyyy-MM-dd').format(endOfYear);

  // Filter invoices by comparing the createdAt date
  return invoices.where((invoice) {
    // Parse the createdAt field as DateTime
    DateTime createdAt = DateTime.parse(invoice['invoiceDate']);

    // Format the createdAt date as yyyy-MM-dd
    String invoiceDate = DateFormat('yyyy-MM-dd').format(createdAt);

    // Check if the invoice date is within this year
    return invoiceDate.compareTo(startOfYearStr) >= 0 &&
        invoiceDate.compareTo(endOfYearStr) <= 0;
  }).toList();
}

extension on DateTime {
  // Get the start of the day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  // Get the end of the day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);
}
