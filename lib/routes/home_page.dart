

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/routes/trading_scaffold.dart';
import 'package:namer_app/redux/nav_bar_index.dart';
import 'package:namer_app/routes/trade_asset.dart';
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
        TradeAsset(),
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