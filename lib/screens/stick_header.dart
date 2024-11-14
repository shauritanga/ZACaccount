import 'package:flutter/material.dart';

class SingleStickyHeaderList extends StatelessWidget {
  final List<Map<String, dynamic>> data = const [
    {
      'header': 'Section 1',
      'items': ['Item 1.1', 'Item 1.2', 'Item 1.3']
    },
    {
      'header': 'Section 2',
      'items': ['Item 2.1', 'Item 2.2', 'Item 2.3', 'Item 2.4']
    },
    {
      'header': 'Section 3',
      'items': ['Item 3.1', 'Item 3.2']
    },
  ];

  const SingleStickyHeaderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single Sticky Header List')),
      body: CustomScrollView(
        slivers: [
          for (var section in data) ...[
            SliverPersistentHeader(
              pinned: true,
              delegate: _SingleStickyHeaderDelegate(
                minHeight: 50.0,
                maxHeight: 50.0,
                child: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    section['header'],
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildListItem(section['items'][index]);
                },
                childCount: section['items'].length,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildListItem(String item) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        item,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class _SingleStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SingleStickyHeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; // Always rebuild to update content as you scroll.
  }
}
