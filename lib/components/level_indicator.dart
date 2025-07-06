import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelIndicator extends StatelessWidget {
  final String level;
  final bool isCurrentUser;

  const LevelIndicator({
    super.key,
    required this.level,
    this.isCurrentUser = false,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isCurrentUser
            ? const Color(0xFF4F46E5).withOpacity(0.5)
            : Colors.white.withOpacity(0.2),
      ),
      child: Text(
        level,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
