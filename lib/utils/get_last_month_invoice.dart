double totalInvoiceLastMonth(List<Map<String, dynamic>> invoices) {
  DateTime now = DateTime.now();
  DateTime lastMonthDate = DateTime(now.year, now.month - 1, 1);
  int lastMonthYear = lastMonthDate.year;
  int lastMonth = lastMonthDate.month;

  // Filter and sum invoices from the last month
  double totalAmountLastMonth = invoices
      .where((invoice) {
        DateTime invoiceDate = DateTime.parse(invoice['invoiceDate']);
        return invoiceDate.year == lastMonthYear &&
            invoiceDate.month == lastMonth;
      })
      .map((invoice) => invoice['totalAmount'])
      .fold(0.0, (sum, amount) => sum + amount);

  // Print the total sum of invoices from last month
  return totalAmountLastMonth;
}
