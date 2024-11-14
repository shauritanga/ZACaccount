import 'package:flutter/material.dart';

class VerticalSeparater extends StatelessWidget {
  const VerticalSeparater({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 14,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
    );
  }
}
