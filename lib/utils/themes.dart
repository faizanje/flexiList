import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/constant/constant.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    appBarTheme: AppBarTheme(color: kPrimaryColor),
    backgroundColor: Colors.white,
    buttonColor: Colors.blue,
    accentColor: Colors.white,
    colorScheme: ColorScheme.light().copyWith(
      primary: Color(0xFF020D46),
    ),
    primaryColorDark: Colors.white,
    textTheme: GoogleFonts.nunitoTextTheme().copyWith(
      button: TextStyle(color: Colors.white),
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    // cardTheme: CardTheme(color: Colors.redAccent),
    // cardColor: Colors.deepOrange,
    iconTheme: IconThemeData(color: Color(0xFF69F2DD)),
    scaffoldBackgroundColor: Color(0xFF241B35),
    appBarTheme: AppBarTheme(color: Color(0xFF241B35)),
    primaryColor: Color(0xFF69F2DD),
    primaryColorDark: Color(0xFF413C4E),
    backgroundColor: Color(0xFF241B35),
    accentColor: Colors.black,
    // backgroundColor: Color(0xFF263238),
    buttonColor: Color(0xFF69F2DD),
    // buttonTheme: ElevatedButtonThemeData(
    //
    // ),
    colorScheme: ColorScheme.light().copyWith(
      primary: Color(0xFF69F2DD),
    ),

    textTheme: GoogleFonts.nunitoTextTheme()
        .copyWith(
          // button: TextStyle(color: Colors.black),
          // bodyText1: TextStyle(),
          bodyText1: GoogleFonts.nunito(),
          bodyText2: GoogleFonts.nunito(),
        )
        .apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
  );
}
