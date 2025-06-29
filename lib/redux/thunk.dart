import 'dart:convert';

import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'market.dart';
import 'state.dart';
import 'dart:developer';

ThunkAction<AppState> fetchData = (Store<AppState> store) async {
  try {
    final response = await http.get(
      Uri.parse('${store.state.extendedBaseUrl}/api/v1/info/markets'),
    );
    if (response.statusCode == 200) {
      // Parse the response data
      final dynamic data = jsonDecode(response.body);
      final List<Market> markets = [];
      for (var item in data['data'] as List<dynamic>) {
        final market = Market.fromJson(item as Map<String, dynamic>);
        markets.add(market);
        // Here you would typically dispatch an action to update the state with the new card
        // store.dispatch(GetTradeCardAction(cards: [card]));
      }
       store.dispatch(GetMarketsAction(markets: markets));
    } else {
       store.dispatch(Error('Error: ${response.statusCode}'));
    }
  } catch (e) {
     store.dispatch(Error('Error: ${e}'));
  }
  log("Data fetched successfully");
};
