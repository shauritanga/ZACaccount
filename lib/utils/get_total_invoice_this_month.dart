
double getThisMonthInvoice(List<Map<String, dynamic>> invoices) {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;

  // Filter invoices by the current month and year
  List<Map<String, dynamic>> currentMonthInvoices = invoices.where((invoice) {
    DateTime invoiceDate = DateTime.parse(invoice['invoiceDate']);
    return invoiceDate.year == currentYear && invoiceDate.month == currentMonth;
  }).toList();

  // Calculate the sum of the 'amount' field for invoices of the current month
  double totalAmount = currentMonthInvoices.fold(
      0.0, (sum, invoice) => sum + (invoice['totalAmount'] as double));

  // Print the total amount
  return totalAmount;
}
