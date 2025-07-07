import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finroit/redux/nav_bar_index.dart';

class NavBar extends ConsumerWidget {
  NavBar({super.key });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(navBarIndexProvider).index;
    log("Current index: $currentIndex");
    return Container(
      // height: 56,
      child: BottomNavigationBar(
        backgroundColor: Color(0xFF111827),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white10,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(Icon(Icons.trending_up), currentIndex == 0),
            label: 'Trade',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icon(Icons.group), currentIndex == 1),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icon(Icons.person_outline), currentIndex == 2),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex, // Set the index for the Trade tab
        onTap: (index) {
          ref.read(navBarIndexProvider.notifier).setIndex(index);
          // final indexx = ref.watch(navBarIndexProvider).index;
          // log("Tapped index: $indexx");
          // log('NavBar tapped: $x');
        },
      ),
    );
  }
}


Widget _buildNavItem(Widget icon, bool isActive ) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      icon,
      if (isActive)
        Container(
          margin: EdgeInsets.only(top: 4),
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
    ],
  );
}
