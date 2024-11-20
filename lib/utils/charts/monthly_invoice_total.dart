Map<String, double> groupInvoiceDataByMonth(List<Map<String, dynamic>> data) {
  Map<String, double> monthlyTotals = {};

  // Get the current year
  DateTime today = DateTime.now();
  int currentYear = today.year;

  for (var entry in data) {
    DateTime entryDate = DateTime.parse(entry['invoiceDate']);

    // Only include entries within the current year
    if (entryDate.year == currentYear) {
      // Create a key for the current month (e.g., "01", "02")
      String monthKey = entryDate.month.toString().padLeft(2, '0');

      // Add the entry's balance to the monthly total
      monthlyTotals.update(
        monthKey,
        (value) => value + entry['totalAmount'],
        ifAbsent: () => entry['totalAmount'],
      );
    }
  }

  return monthlyTotals;
}
