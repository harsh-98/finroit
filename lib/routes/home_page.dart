import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/routes/trading_scaffold.dart';
import 'package:namer_app/redux/nav_bar_index.dart';
import 'package:namer_app/routes/trade_asset.dart';
import 'package:namer_app/routes/leaderboard_page.dart';
import '../components/nav_bar.dart';
import '../components/card_deck.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<Widget> w =  [
        TradingScaffold(),
        Stack(
          children: [
            LeaderboardPage(),
            Positioned(
            bottom: 100, // Positioned above the bottom navigation
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEC4899).withOpacity(0.5),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          ],
        ),
        Center(child: CardDeck())
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F172A),
          body: w[ref.watch(navBarIndexProvider).index],
      bottomNavigationBar: NavBar(),
    );
  }
}
