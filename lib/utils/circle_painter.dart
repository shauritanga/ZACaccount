import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zaccount/utils/constants.dart';

class CirclePainter extends CustomPainter {
  final double progress; // Progress of the dot around the circle
  final Paint circlePaint;
  final Paint trackPaint;
  final Paint dotPaint;

  CirclePainter(this.progress)
      : circlePaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0,
        trackPaint = Paint()
          ..color = primary // Same color as dot
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0 // Make track a bit wider to match the dot
          ..strokeCap = StrokeCap.round,
        dotPaint = Paint()
          ..color = primary
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    double radius =
        min(size.width / 2, size.height / 2) - 20; // Radius of the circle
    Offset center =
        Offset(size.width / 2, size.height / 2); // Center of the canvas

    // Draw the circle outline
    canvas.drawCircle(center, radius, circlePaint);

    // Calculate the position of the moving dot based on the progress (0 to 1)
    double angle =
        2 * pi * progress - pi / 2; // Adjust angle to start at the top
    Offset dotPosition = Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    );

    // Draw the track (arc) based on the dot's progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start the arc from the top (-90 degrees)
      2 * pi * progress, // Arc angle based on the current progress
      false,
      trackPaint,
    );

    // Draw the moving dot
    canvas.drawCircle(dotPosition, 7.0, dotPaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
