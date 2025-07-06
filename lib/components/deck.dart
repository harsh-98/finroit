import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/components/trade_card.dart';
import 'package:namer_app/redux/market.dart';
import 'package:namer_app/redux/nav_bar_index.dart';

class Deck extends StatefulWidget {
  @override
  State<Deck> createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  int _currentCardIndex = 0;
  PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      height: 374,
      child: Stack(
        children: [
          // Gradient background
          Positioned(
            left: 14,
            top: -70,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.7071,
                  colors: [
                    Color(0xFF6366F1).withOpacity(0.15),
                    Color(0xFF6366F1).withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Asset cards
          Consumer(
            builder: (context, ref, child) {
              final _markets = ref.watch(marketsProvider);
              final categoryIndex = ref.watch(categoryIndexProvider);
              final markets =
                  _markets.markets[_markets.categories[categoryIndex.index]] ??
                  [];
              return PageView.builder(
                controller: _pageController,
                itemCount: markets.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentCardIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return buildAssetCard(
                    markets[index],
                    index == _currentCardIndex,
                  );
                },
              );
            },
          ),
          // Navigation arrows
          Positioned(
            left: 20,
            top: 187,
            child: _buildNavigationButton(Icons.chevron_left, () {
              if (_currentCardIndex > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }),
          ),
          Positioned(
            right: 20,
            top: 187,
            child: _buildNavigationButton(Icons.chevron_right, () {
              // if (_currentCardIndex < markets.length - 1) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              // }
            }),
          ),
        ],
      ),
    );
  }
}

Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xFF1E293B).withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    ),
  );
}
