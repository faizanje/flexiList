import 'package:flutter/material.dart';
import 'package:noteapp/constant/constant.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.0050000);
    path_0.quadraticBezierTo(size.width * 0.9030000, size.height * 0.1027500,
        size.width * 0.9000000, size.height * 0.3000000);
    path_0.cubicTo(
        size.width * 0.8502500,
        size.height * 0.4036500,
        size.width * 0.7512500,
        size.height * 0.3938000,
        size.width * 0.7486000,
        size.height * 0.5007000);
    path_0.cubicTo(
        size.width * 0.7500000,
        size.height * 0.6103500,
        size.width * 0.8515000,
        size.height * 0.6000000,
        size.width * 0.8953000,
        size.height * 0.7000000);
    path_0.quadraticBezierTo(size.width * 0.8997500, size.height * 0.9026500,
        size.width, size.height);
    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
