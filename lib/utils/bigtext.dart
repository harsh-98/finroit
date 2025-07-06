import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget bigText(String text, Color color) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 40,
      color: color,
      // fontWeight: FontWeight.bold,
    ),
  );
}

class _style {
  late TextStyle bigger;
  late TextStyle big;
  late TextStyle midWhite;
  late TextStyle midLess;
  late TextStyle smallWhite;
  late TextStyle smallLess;
  late TextStyle smaller;
  _style({
    required this.bigger,
    required this.big,
    required this.midWhite,
    required this.midLess,
    required this.smallWhite,
    required this.smallLess,
    required this.smaller,
  });
}

_style textstyle = _style(
  bigger: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
  big: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
  midWhite: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
  midLess: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9CA3AF),
  ),
  smallLess: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9CA3AF),
  ),
  smallWhite: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  smaller: GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: Colors.white.withOpacity(0.6),
  ),
);
