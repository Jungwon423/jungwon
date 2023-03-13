import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white, // 기본 바탕색
      textTheme: textTheme(), // 텍스트 디자인
      appBarTheme: appbarTheme(), // 앱 바 디자인
      primaryColor: Colors.white);
}

TextTheme textTheme() {
  return TextTheme(
    displayLarge: GoogleFonts.nanumGothic(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.nanumGothic(fontSize: 10.0, color: Colors.black),
    titleMedium: GoogleFonts.nanumGothic(
        fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold),
  );
}

AppBarTheme appbarTheme() {
  return AppBarTheme(
    centerTitle: false,
    color: Colors.white,
    elevation: 0.0,
    titleTextStyle: GoogleFonts.nanumGothic(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );
}