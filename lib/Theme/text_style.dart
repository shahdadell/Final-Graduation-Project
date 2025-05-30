import 'package:flutter/material.dart';
import 'package:graduation_project/Theme/theme.dart';

TextStyle getFont30TextStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: fontSize ?? 30,
    color: color ?? MyTheme.blackColor,
  );
}

TextStyle getFont24TextStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: fontSize ?? 24,
    color: color ?? MyTheme.blackColor,
  );
}

TextStyle getFont20TextStyle(
    {double? fontSize, Color? color, FontWeight? fontWeight}) {
  return TextStyle(
    fontSize: fontSize ?? 20,
    color: color ?? MyTheme.grayColor,
  );
}

TextStyle getFont18TextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontSize: fontSize ?? 18,
    color: color ?? MyTheme.blackColor,
  );
}

TextStyle getFont16TextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontSize: fontSize ?? 16,
    color: color ?? MyTheme.blackColor,
  );
}

TextStyle getFont14TextStyle({double? fontSize, Color? color}) {
  return TextStyle(
    fontSize: fontSize ?? 14,
    color: color ?? MyTheme.blackColor,
  );
}
