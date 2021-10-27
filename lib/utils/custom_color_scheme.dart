import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  Color get listColor1 =>
      brightness == Brightness.light ? Colors.white : Colors.white30;
  Color get listColor2 =>
      brightness == Brightness.light ? Colors.yellow : Color(0xFF3E065F);
  Color get listColor3 => brightness == Brightness.light
      ? Colors.greenAccent
      : const Color(0xFF1E5128);
  Color get listColor4 =>
      brightness == Brightness.light ? Colors.cyan : const Color(0xFF3D0000);
  Color get listColor5 => brightness == Brightness.light
      ? Colors.redAccent
      : const Color(0xFF321F28);
  Color get listColor6 => brightness == Brightness.light
      ? Colors.deepPurple.shade200
      : const Color(0xFF16213E);
  Color get listColor7 => brightness == Brightness.light
      ? Colors.amber.shade300
      : const Color(0xFF222831);

  Color get listColor8 => brightness == Brightness.light
      ? Colors.deepOrangeAccent
      : const Color(0xFF393232);
  Color get listColor9 =>
      brightness == Brightness.light ? Colors.white60 : const Color(0x2228a745);
}
