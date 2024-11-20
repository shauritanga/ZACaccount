import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zaccount/utils/charts/daily_expense_total.dart';
import 'package:zaccount/utils/charts/daily_invoice_total.dart';

class DailyRevenueExpenseChart extends StatelessWidget {
  final List<Map<String, dynamic>> invoices;
  final List<Map<String, dynamic>> expenses;

  const DailyRevenueExpenseChart(
      {super.key, required this.invoices, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Group data by day for simplicity
    Map<String, double> dailyInvoices = groupInvoiceDataByDay(invoices);
    Map<String, double> dailyExpenses = groupExpenseDataByDay(expenses);

    // Prepare index-to-label map for displaying days
    Map<int, String> indexToLabel = {};
    List<BarChartGroupData> barGroups = [];

    // Create BarChartGroupData for each day (revenue and expense)
    int index = 0;
    dailyInvoices.forEach((date, invoiceTotal) {
      double expenseTotal = dailyExpenses[date] ?? 0.0;

      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: invoiceTotal,
              color: Colors.blue,
              width: 10,
            ),
            BarChartRodData(
              toY: expenseTotal,
              color: Colors.red,
              width: 10,
            ),
          ],
        ),
      );
      indexToLabel[index] = date;
      index++;
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          barGroups: barGroups,
          borderData: FlBorderData(
            border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide(width: 1),
              bottom: BorderSide(width: 1),
            ),
          ),
          titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${(value / 1000000).toStringAsFixed(1)}M',
                    style: const TextStyle(fontSize: 12),
                  );
                },
              )),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      indexToLabel[value.toInt()] ?? '',
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                  interval: 1,
                ),
              )),
          gridData: const FlGridData(show: true),
        ),
      ),
    );
  }

  // Function to group data by day (example)
}
