import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographyApp {
  static TextStyle displayLarge = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(57),
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(45),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle displaySmall = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(36),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle headlineLarge = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(32),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(28),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle headlineSmall = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(24),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle titleLarge = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(22),
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle titleMedium = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle bodyLarge = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(16),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(12),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  static TextStyle labelLarge = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(12),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontSize: ScreenUtil().setSp(11),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
