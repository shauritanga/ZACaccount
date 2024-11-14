import 'package:flutter/material.dart';
import 'package:zaccount/utils/circle_painter.dart';

class CircleAnimation extends StatefulWidget {
  const CircleAnimation({super.key});

  @override
  _CircleAnimationState createState() => _CircleAnimationState();
}

class _CircleAnimationState extends State<CircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Loop the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: CirclePainter(
                  _controller.value), // Pass the animation progress
              size: const Size(150, 150), // Set the size of the circle
            );
          },
        ),
      ),
    );
  }
}
