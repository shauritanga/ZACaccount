import 'package:intl/intl.dart';

List<Map<String, dynamic>> getInvoicesCreatedToday(
    List<Map<String, dynamic>> invoices) {
  // Get today's date in the format yyyy-MM-dd
  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Filter the invoices created today
  return invoices.where((invoice) {
    // Parse the createdAt field to DateTime
    DateTime createdAt = DateTime.parse(invoice['invoiceDate']);

    // Format the DateTime to compare only the date part (yyyy-MM-dd)
    String invoiceDate = DateFormat('yyyy-MM-dd').format(createdAt);

    return invoiceDate == today;
  }).toList();
}
