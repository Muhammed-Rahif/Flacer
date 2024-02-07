import 'dart:math';

import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  ArcPainter({
    required this.progressColor,
    required this.trackColor,
    required this.animation,
  }) : super(repaint: animation);

  Color progressColor;
  Color trackColor;
  Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final progressCircle = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 5;
    final bgCircle = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 5;

    final arcRect = Rect.fromCircle(
        center: size.bottomCenter(Offset.zero), radius: size.shortestSide);
    const startDeg = 165 * pi / 180;
    const swapDeg = (210) * pi / 180;

    canvas.drawArc(arcRect, startDeg, swapDeg, false, progressCircle);
    canvas.drawArc(
        arcRect, startDeg, swapDeg * animation.value, false, bgCircle);
  }

  @override
  bool shouldRepaint(ArcPainter oldDelegate) => false;
}
