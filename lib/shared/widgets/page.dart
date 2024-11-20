import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:zaccount/presentation/providers/expense_provider.dart';
import 'package:zaccount/presentation/providers/invoice_provider.dart';
import 'package:zaccount/utils/get_last_month_invoice.dart';
import 'package:zaccount/utils/get_total_expense_this_month.dart';
import 'package:zaccount/utils/get_total_invoice_this_month.dart';
import 'package:zaccount/utils/total_expense_last_month.dart';

class IncomeDashboard extends ConsumerStatefulWidget {
  const IncomeDashboard({super.key});

  @override
  ConsumerState createState() => _IncomeDashboardState();
}

class _IncomeDashboardState extends ConsumerState<IncomeDashboard> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoices = ref.watch(invoicesFurureProvider);
    final expenses = ref.watch(expenseFurureProvider);
    return Scaffold(
      body: SafeArea(
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    IncomeCard(
                      title: 'Total income this month',
                      totalIncome:
                          NumberFormat().format(getThisMonthInvoice(invoices)),
                      difference: NumberFormat().format(
                          getThisMonthExpense(expenses) -
                              totalInvoiceLastMonth(invoices)),
                      isDecrease: true,
                    ),
                    IncomeCard(
                      title: 'Total expense this month',
                      totalIncome:
                          NumberFormat().format(getThisMonthExpense(expenses)),
                      difference: NumberFormat().format(
                          getThisMonthExpense(expenses) -
                              totalExpenseLastMonth(expenses)),
                      isDecrease: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 2,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue.shade700,
                    dotColor: Colors.grey.shade300,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 4,
                    expansionFactor: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncomeCard extends StatelessWidget {
  final String totalIncome;
  final String difference;
  final bool isDecrease;
  final String title;

  const IncomeCard({
    super.key,
    required this.totalIncome,
    required this.difference,
    required this.isDecrease,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Tsh $totalIncome",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  isDecrease
                      ? Icons.arrow_circle_down_outlined
                      : Icons.arrow_circle_up_outlined,
                  color: isDecrease ? Colors.red[400] : Colors.green[400],
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '$difference ${isDecrease ? 'below' : 'above'} last month',
                  style: TextStyle(
                    color: isDecrease ? Colors.red[400] : Colors.green[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInvoiceStatus(Colors.amber, '0 invoice awaiting approval'),
            const SizedBox(height: 8),
            _buildInvoiceStatus(Colors.green, '0 invoice awaiting approval'),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceStatus(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
