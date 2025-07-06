import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AchievementBadge extends StatelessWidget {
  final String letter;
  final Color color;

  const AchievementBadge({
    super.key,
    required this.letter,
    required this.color,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
