
double getThisMonthExpense(List<Map<String, dynamic>> expenses) {
  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;

  // Filter invoices by the current month and year
  List<Map<String, dynamic>> currentMonthInvoices = expenses.where((expense) {
    DateTime invoiceDate = DateTime.parse(expense['dueDate']);
    return invoiceDate.year == currentYear && invoiceDate.month == currentMonth;
  }).toList();

  // Calculate the sum of the 'amount' field for invoices of the current month
  double totalAmount = currentMonthInvoices.fold(
      0.0, (sum, expense) => sum + (expense['totalAmount'] as double));

  // Print the total amount
  return totalAmount;
}
