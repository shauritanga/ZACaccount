Map<String, double> groupExpenseDataByWeek(List<Map<String, dynamic>> data) {
  Map<String, double> weeklyTotals = {};

  // Get the current date and determine the start of the current month
  DateTime today = DateTime.now();
  DateTime startOfMonth = DateTime(today.year, today.month, 1);
  DateTime endOfMonth =
      DateTime(today.year, today.month + 1, 0); // Last day of the current month

  // Iterate through each week in the current month
  DateTime currentWeekStart = startOfMonth;
  while (currentWeekStart.isBefore(endOfMonth)) {
    DateTime currentWeekEnd = currentWeekStart.add(const Duration(days: 6));
    if (currentWeekEnd.isAfter(endOfMonth)) {
      currentWeekEnd = endOfMonth; // Cap the last week at the end of the month
    }

    // Calculate total balance for the current week
    double weeklyTotal = 0.0;
    for (var entry in data) {
      DateTime entryDate = DateTime.parse(entry['dueDate']);

      // Include only entries within the current week and month
      if (entryDate
              .isAfter(currentWeekStart.subtract(const Duration(days: 1))) &&
          entryDate.isBefore(currentWeekEnd.add(const Duration(days: 1)))) {
        weeklyTotal += entry['totalAmount'];
      }
    }

    // Create a key for the current week (e.g., "Week 1", "Week 2")
    String weekKey = 'Week ${((currentWeekStart.day - 1) / 7).floor() + 1}';
    weeklyTotals[weekKey] = weeklyTotal;

    // Move to the next week
    currentWeekStart = currentWeekStart.add(const Duration(days: 7));
  }

  return weeklyTotals;
}
