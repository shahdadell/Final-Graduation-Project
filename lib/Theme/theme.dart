import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static Color orangeColor = const Color(0xffF87146);
  static Color orangeColor2 = const Color(0xffF26B0A);
  static Color blueColor = const Color(0xff5384EE);
  static Color yellowColor = const Color(0xffFECC63);
  static Color mauveColor = const Color(0xff332C45);
  static Color blueColor2 = const Color(0xff415792);
  static Color blackColor = const Color(0xff000000);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color grayColor = const Color(0xffD6D6D6);
  static Color grayColor2 = const Color(0xff878787);
  static Color grayColor3 = const Color.fromARGB(20, 158, 158, 158);
  static Color iconGrayColor = const Color.fromARGB(200, 158, 158, 158);
  static Color greenColor = const Color(0xff4CAF50);
  static Color lowOpacity = const Color(0xffFFD6DD);
  static Color transparent = const Color(0x00000000);
  static const Color primaryColor = Color(0xffBFA054);
  static const Color redColor = Color(0xffFF4667);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    textTheme: TextTheme(
      titleSmall: GoogleFonts.dmSerifDisplay(
          color: blackColor, fontSize: 16, fontWeight: FontWeight.bold),
      titleMedium: GoogleFonts.dmSerifDisplay(
          color: blackColor, fontSize: 18, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.dmSerifDisplay(
          color: blackColor, fontSize: 24, fontWeight: FontWeight.w500),
      bodySmall: GoogleFonts.dmSerifDisplay(
          color: orangeColor2, fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.dmSerifDisplay(
          color: orangeColor2, fontSize: 18, fontWeight: FontWeight.bold),
      bodyLarge: GoogleFonts.dmSerifDisplay(
          color: orangeColor2, fontSize: 24, fontWeight: FontWeight.bold),
      displaySmall: GoogleFonts.dmSerifDisplay(
          color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500),
      displayMedium: GoogleFonts.dmSerifDisplay(
          color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
      displayLarge: GoogleFonts.dmSerifDisplay(
          color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}
