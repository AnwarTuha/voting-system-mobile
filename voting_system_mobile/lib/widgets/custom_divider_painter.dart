import 'package:flutter/material.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class DrawHorizontalLine extends CustomPainter {
  Paint _paint;
  bool reverse;

  DrawHorizontalLine(this.reverse) {
    _paint = Paint()
      ..color = tealColors
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (reverse) {
      canvas.drawLine(Offset(-250.0, 0.0), Offset(-10.0, 0.0), _paint);
    } else {
      canvas.drawLine(Offset(10.0, 0.0), Offset(250.0, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}