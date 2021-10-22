import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';
import 'dart:ui' as ui;

//Copy this CustomPainter code to the Bottom of the File
import 'dart:ui' as ui;

class RPSCustomPainter extends CustomPainter {
  BuildContext context;
  RPSCustomPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Theme.of(this.context).primaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(size.width * 1.0066000, size.height * 0.1493000);
    path_0.quadraticBezierTo(size.width * 0.8570000, size.height * 0.1995000,
        size.width * 0.8538000, size.height * 0.2765000);
    path_0.cubicTo(
        size.width * 0.8498000,
        size.height * 0.4315000,
        size.width * 0.3611000,
        size.height * 0.3877000,
        size.width * 0.3626000,
        size.height * 0.4925000);
    path_0.cubicTo(
        size.width * 0.3622000,
        size.height * 0.5894000,
        size.width * 0.8578000,
        size.height * 0.5715000,
        size.width * 0.8578000,
        size.height * 0.7147000);
    path_0.quadraticBezierTo(size.width * 0.8578000, size.height * 0.7855000,
        size.width * 1.0066000, size.height * 0.8486000);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
