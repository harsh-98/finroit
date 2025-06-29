import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:namer_app/redux/market.dart';
import 'package:namer_app/redux/thunk.dart';
import 'package:redux/redux.dart';
import '../redux/state.dart';
import 'card.dart';

class CardDeck extends StatelessWidget {

  const CardDeck({super.key});

  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
      converter: (store) => store,
      // onInitialBuild: (store )=>store.dispatch(fetchData),
      builder:(context, store) => ListView(
        scrollDirection: Axis.vertical,
        children: (store.state.markets[store.state.category] ?? []).where((obj) => obj.active).map((market) {
          return TradeCard(details: market);
        }).toList(),
      ),
    );
  }
}