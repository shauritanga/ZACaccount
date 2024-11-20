double totalExpenseLastMonth(List<Map<String, dynamic>> expenses) {
  DateTime now = DateTime.now();
  DateTime lastMonthDate = DateTime(now.year, now.month - 1, 1);
  int lastMonthYear = lastMonthDate.year;
  int lastMonth = lastMonthDate.month;

  // Filter and sum invoices from the last month
  double totalAmountLastMonth = expenses
      .where((expense) {
        DateTime invoiceDate = DateTime.parse(expense['dueDate']);
        return invoiceDate.year == lastMonthYear &&
            invoiceDate.month == lastMonth;
      })
      .map((expense) => expense['totalAmount'])
      .fold(0.0, (sum, amount) => sum + amount);

  // Print the total sum of invoices from last month
  return totalAmountLastMonth;
}
