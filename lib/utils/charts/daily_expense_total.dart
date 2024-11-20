Map<String, double> groupExpenseDataByDay(List<Map<String, dynamic>> data) {
  Map<String, double> dailyTotals = {};

  // Get the current date and determine the start of the current week (Monday)
  DateTime today = DateTime.now();
  DateTime startOfWeek = today.subtract(
      Duration(days: today.weekday - 1)); // Monday is the start of the week

  for (var entry in data) {
    DateTime entryDate = DateTime.parse(entry['dueDate']);

    // Only include entries within the current week
    if (entryDate.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        entryDate.isBefore(today.add(const Duration(days: 1)))) {
      String dayKey =
          '${entryDate.month.toString().padLeft(2, '0')}/${entryDate.day.toString().padLeft(2, '0')}';
      dailyTotals.update(dayKey, (value) => value + entry['totalAmount'],
          ifAbsent: () => entry['totalAmount']);
    }
  }

  return dailyTotals;
}
