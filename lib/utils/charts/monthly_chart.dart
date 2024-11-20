import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zaccount/utils/charts/monthly_expense_total.dart';
import 'package:zaccount/utils/charts/monthly_invoice_total.dart';

class MonthlyRevenueExpenseChart extends StatelessWidget {
  final List<Map<String, dynamic>> invoices;
  final List<Map<String, dynamic>> expenses;

  const MonthlyRevenueExpenseChart(
      {super.key, required this.invoices, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Group data by day for simplicity
    Map<String, double> monthlyInvoices = groupInvoiceDataByMonth(invoices);
    Map<String, double> monthlyExpenses = groupExpenseDataByMonth(expenses);

    // Prepare index-to-label map for displaying days
    Map<int, String> indexToLabel = {};
    List<BarChartGroupData> barGroups = [];

    // Create BarChartGroupData for each day (revenue and expense)
    int index = 0;
    monthlyInvoices.forEach((date, invoiceTotal) {
      double expenseTotal = monthlyExpenses[date] ?? 0.0;

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
                    style: const TextStyle(fontSize: 10),
                  );
                },
              )),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String lable = "";
                    switch (indexToLabel[value.toInt()]) {
                      case '12':
                        lable = "Dec";
                        break;
                      case '11':
                        lable = "Nov";
                        break;
                      case '10':
                        lable = "Oct";
                        break;
                      case '09':
                        lable = "Sep";
                        break;
                      case '08':
                        lable = "Aug";
                        break;
                      case '07':
                        lable = "Jul";
                        break;
                      case '06':
                        lable = "Jun";
                        break;
                      case '05':
                        lable = "May";
                        break;
                      case '04':
                        lable = "Apr";
                        break;
                      case '03':
                        lable = "Mar";
                        break;
                      case '02':
                        lable = "Feb";
                        break;
                      case '01':
                        lable = "Jan";
                        break;
                    }
                    return Text(
                      lable,
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                  interval: 1,
                ),
              )),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(
            border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide(width: 1),
              bottom: BorderSide(width: 1),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.black,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  "${NumberFormat("#,##0.00").format(rod.toY / 1000000)}M",
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
