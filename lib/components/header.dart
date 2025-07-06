import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/redux/user.dart';
import '../utils/bigtext.dart';

class Header extends StatelessWidget {
  final UserState userState;
  Header({super.key, required this.userState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          // User level badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
              ),
            ),
            child: Center(
              child: Text(
                userState.level,
                style: textstyle.midWhite,
              ),
            ),
          ),
          SizedBox(width: 8),
          // User info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userState.name,
                style: textstyle.midWhite,
              ),
              Text(
                '${userState.XP} XP',
                style: textstyle.smallLess,
              ),
            ],
          ),
          Spacer(),
          // Action buttons
          _buildActionButton(Icons.shopping_cart_outlined),
          SizedBox(width: 12),
          _buildActionButton(Icons.notifications_outlined),
        ],
      ),
    );
  }
}

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF1F2937),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }