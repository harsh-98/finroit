import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'card.dart';
import '../redux/market.dart';

class CardDeck extends ConsumerWidget {
  const CardDeck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(marketsProvider);
    return store.when(
      data: (markets) => getcards(markets.getMarketsByCategory('L1')),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}

Widget getcards(List<Market> ms) {
  return ListView(
    scrollDirection: Axis.vertical,
    children: ms.where((obj) => obj.active).map((market) {
      return TradeCard(details: market);
    }).toList(),
  );
}
