import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScrollableCardWithIndicator extends StatefulWidget {
  const ScrollableCardWithIndicator({super.key});

  @override
  _ScrollableCardWithIndicatorState createState() =>
      _ScrollableCardWithIndicatorState();
}

class _ScrollableCardWithIndicatorState
    extends State<ScrollableCardWithIndicator> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horizontal Scrollable Card with Indicator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // The scrollable cards
            SizedBox(
              height: 180, // Height of the card
              child: PageView(
                controller: _controller,
                children: [
                  buildIncomeCard(
                    context,
                    "Total income this month",
                    "TSZ 5,900.00",
                    "TSZ 7,080.00 below last month",
                  ),
                  buildIncomeCard(
                    context,
                    "Total expenses this month",
                    "TSZ 2,500.00",
                    "TSZ 1,000.00 below last month",
                  ),
                  // Add more cards as needed
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Indicator
            SmoothPageIndicator(
              controller: _controller,
              count: 2, // Number of cards/pages
              effect: const WormEffect(
                activeDotColor: Colors.blue, // Active indicator color
                dotColor: Colors.grey, // Inactive indicator color
                dotHeight: 10,
                dotWidth: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIncomeCard(
    BuildContext context,
    String title,
    String totalIncome,
    String comparison,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              totalIncome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  comparison,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                buildApprovalStatusIndicator(
                    Colors.yellow, "0 invoice awaiting approval"),
                const SizedBox(width: 10),
                buildApprovalStatusIndicator(
                    Colors.green, "0 invoice approved"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildApprovalStatusIndicator(Color color, String text) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 12,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}
