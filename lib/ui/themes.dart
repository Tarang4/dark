import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color blue = const Color(0xff4e5ae8);
Color yellow = const Color(0xffffb746);
Color pink = const Color(0xffff4647);
Color darkGrey = const Color(0xff121212);
Color hardGrey = const Color(0xff424242);
Color white = Colors.white;
Color primeColor = blue;

class Themes {
  static final dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkGrey,
      backgroundColor: darkGrey);

  static final light = ThemeData(
    backgroundColor: blue,
    primaryColor: primeColor,
    brightness: Brightness.light,
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 22,
          color: Get.isDarkMode ? Colors.grey : Colors.grey[400]));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get buttonExtraSmallStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 13,
      color: Colors.grey[200],
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle get taskExtraSmallStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 13,
      wordSpacing: 1,
      color: Colors.grey[900],
      fontWeight: FontWeight.w400,
    ),
  );
}

TextStyle get taskSmallStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      color: Colors.grey[900],
      fontWeight: FontWeight.w500,
    ),
  );
}

TextStyle get taskStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 18,
      color: Colors.grey[900],
      fontWeight: FontWeight.bold,
    ),
  );
}
