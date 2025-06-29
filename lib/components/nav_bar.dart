import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Trade'),
        BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'Clan'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
      ],
      currentIndex: 0, // Set the index for the Trade tab
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/trade');
        } else if (index == 1) {
          // Navigate to leaderboard
          Navigator.pushNamed(context, '/clan'); 
        } else if (index == 2) {
          Navigator.pushNamed(context, '/user');
        }
      },
    );
  }
}
