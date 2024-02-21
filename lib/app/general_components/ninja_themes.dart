  import 'package:flutter/material.dart';

class NourishNinjaTheme {
  NourishNinjaTheme._();
  static const Color nearlyWhite = Color.fromARGB(255, 216, 216, 216);
  static const Color white = Color.fromARGB(255, 28, 255, 183);
  static const Color background = Color.fromARGB(255, 0, 145, 255);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color.fromARGB(255, 205, 0, 181);
  static const Color nearlyBlack = Color.fromARGB(255, 0, 0, 0);
  static const Color grey = Color.fromARGB(255, 108, 108, 108);
  static const Color dark_grey = Color.fromARGB(255, 23, 25, 27);

  static const Color darkText = Color.fromARGB(255, 255, 0, 0);
  static const Color darkerText = Color.fromARGB(255, 255, 146, 45);
  static const Color lightText = Color.fromARGB(255, 238, 248, 103);
  static const Color deactivatedText = Color.fromARGB(255, 255, 94, 94);
  static const Color dismissibleBackground = Color.fromARGB(255, 155, 6, 163);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}