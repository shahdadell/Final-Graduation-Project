import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double size, FontWeight fontWeight, Color color) {
  return GoogleFonts.rubik(
    color: color,
    fontSize: size,
    fontWeight: fontWeight,
  );
}
