import 'package:flutter/material.dart';
import 'package:namer_app/utils/bigtext.dart';

Widget buildTradeButtons() {
  return Row(
    children: [
      button('BUY', [Color(0xFF10B981), Color(0xFF059669)], Color(0xFF10B981).withOpacity(0.3)),
      SizedBox(width: 12),
      button('SELL', [Color(0xFFEF4444), Color(0xFFDC2626)],  Color(0xFFEF4444).withOpacity(0.3)),
    ],
  );
}

Widget button(String text, List<Color> gradientColors, Color shadowColor) {
  return Expanded(
    child: Container(
      height: 41,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(child: Text(text, style: textstyle.midWhite)),
    ),
  );
}
