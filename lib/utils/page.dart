import 'package:flutter/material.dart';

class PageViewWithIndicators extends StatefulWidget {
  const PageViewWithIndicators({super.key});

  @override
  _PageViewWithIndicatorsState createState() => _PageViewWithIndicatorsState();
}

class _PageViewWithIndicatorsState extends State<PageViewWithIndicators> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: const [
              CardPage(
                totalIncome: 'TSZ 5,900.00',
                comparison: 'TSZ 7,080.00 below last month',
                invoices: [
                  {
                    'color': Colors.yellow,
                    'text': '0 invoice awaiting approval'
                  },
                  {
                    'color': Colors.green,
                    'text': '0 invoice awaiting approval'
                  },
                ],
              ),
              CardPage(
                totalIncome: 'TSZ 6,500.00',
                comparison: 'TSZ 6,000.00 above last month',
                invoices: [
                  {
                    'color': Colors.yellow,
                    'text': '1 invoice awaiting approval'
                  },
                  {
                    'color': Colors.green,
                    'text': '2 invoices awaiting approval'
                  },
                ],
              ),
            ],
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentPage == index ? 12.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        );
      }),
    );
  }
}

class CardPage extends StatelessWidget {
  final String totalIncome;
  final String comparison;
  final List<Map<String, dynamic>> invoices;

  const CardPage({super.key, 
    required this.totalIncome,
    required this.comparison,
    required this.invoices,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total income this month',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                totalIncome,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.arrow_downward, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    comparison,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Invoices awaiting approval',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...invoices.map((invoice) {
                return Row(
                  children: [
                    CircleAvatar(
                        radius: 8, backgroundColor: invoice['color']),
                    const SizedBox(width: 8),
                    Text(invoice['text']),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
