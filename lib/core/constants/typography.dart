import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography definitions using GoogleFonts (Gloock for editorial display and DM Sans for UI body)
class AppTypography {
  static TextStyle displayLarge({Color? color}) => GoogleFonts.gloock(
        fontSize: 48,
        fontWeight: FontWeight.w400,
        height: 1.05,
        color: color,
      );

  static TextStyle displayMedium({Color? color}) => GoogleFonts.gloock(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        height: 1.15,
        color: color,
      );

  static TextStyle displaySmall({Color? color}) => GoogleFonts.gloock(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: color,
      );

  static TextStyle titleLarge({Color? color}) => GoogleFonts.dmSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle titleMedium({Color? color}) => GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      );

  static TextStyle bodySmall({Color? color}) => GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color,
      );

  static TextStyle labelLarge({Color? color}) => GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: color,
      );

  static TextStyle labelSmall({Color? color}) => GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
        color: color,
      );
}
