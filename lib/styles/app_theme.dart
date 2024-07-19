import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Color(0xFF4A90E2), // Ana renk
  // accentColor: Color(0xFF50E3C2), // İkincil renk
  // backgroundColor: Color(0xFFF5F5F5), // Arka plan rengi
  scaffoldBackgroundColor: Color(0xFFF5F5F5), // Scaffold arka plan rengi
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.light()
        .textTheme
        .apply(bodyColor: Color(0xFF333333), displayColor: Color(0xFF333333)),
  ).copyWith(
    headlineSmall: GoogleFonts.roboto(
        fontWeight: FontWeight.bold, fontSize: 24.0, color: Color(0xFF333333)),
    headlineMedium: GoogleFonts.roboto(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xFF333333)),
    bodySmall: GoogleFonts.openSans(fontSize: 16.0, color: Color(0xFF333333)),
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, color: Color(0xFF333333)),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFFFF5A5F), // Düğme rengi
    textTheme: ButtonTextTheme.primary,
  ),
);
