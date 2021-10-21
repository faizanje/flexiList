import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/constant/constant.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    backgroundColor: Colors.white,
    buttonColor: Colors.blue,
    colorScheme: ColorScheme.light().copyWith(
      primary: kPrimaryColor,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
  );
  static final dark = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    backgroundColor: Colors.black,
    buttonColor: Colors.red,
    colorScheme: ColorScheme.light().copyWith(
      primary: Colors.black38,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
  );
}
