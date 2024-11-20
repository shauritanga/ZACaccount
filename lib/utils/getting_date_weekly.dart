import 'package:intl/intl.dart';

Map<String, String> getCurrentWeekRange() {
  DateTime today = DateTime.now();

  // Calculate the first day of the current week (Monday)
  DateTime firstDayOfWeek = today.subtract(Duration(days: today.weekday - 1));

  // Calculate the last day of the current week (Sunday)
  DateTime lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

  // Format the dates
  String formattedFirstDay = DateFormat('MMM dd, yyyy').format(firstDayOfWeek);
  String formattedLastDay = DateFormat('MMM dd, yyyy').format(lastDayOfWeek);

  return {
    'firstDate': formattedFirstDay,
    'lastDate': formattedLastDay,
  };
}
