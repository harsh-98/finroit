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
  final TextStyle big;
  final TextStyle mid;
  final TextStyle small;
  _style({
    required this.big,
    required this.mid,
    required this.small,
  });
}

_style textstyle = _style(big: 
  GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
  mid:
  GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  ),
  small:
  GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9CA3AF),
  ),
);
