Map<String, double> groupExpenseDataByYear(List<Map<String, dynamic>> data) {
  Map<String, double> yearlyTotals = {};

  for (var entry in data) {
    DateTime entryDate = DateTime.parse(entry['dueDate']);

    // Create a key for the year (e.g., "2024")
    String yearKey = entryDate.year.toString();

    // Add the entry's balance to the yearly total
    yearlyTotals.update(
      yearKey,
      (value) => value + entry['totalAmount'],
      ifAbsent: () => entry['totalAmount'],
    );
  }

  return yearlyTotals;
}
