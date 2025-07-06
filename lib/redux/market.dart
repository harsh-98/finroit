import 'dart:math';
import 'package:namer_app/redux/const.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'market.g.dart';


class Markets {
  final Map<String, List<Market>> markets;

  Markets({required this.markets});

  List<Market> getMarketsByCategory(String category) {
    return markets[category] ?? [];
  }

  List<String> getCategories() {
    return markets.keys.toList();
  }
}
@riverpod
Future<Markets> markets(MarketsRef ref) async {
  if (true ) {
    // This is a placeholder for the market data.
    // In a real application, you would fetch this data from an API or database.
    return Markets(markets: Map<String, List<Market>>.from({'L1': [
      Market.dummy(),
      Market.dummy(),
      Market.dummy(),
    ]}));
  }
  // This is a placeholder for the market data.
  // In a real application, you would fetch this data from an API or database.
    final response = await http.get(
      Uri.parse('${ref.read(constantsProvider )}/api/v1/info/markets'),
    );
    if (response.statusCode == 200) {
      // Parse the response data
      final dynamic data = jsonDecode(response.body);
      final Map<String, List<Market>> markets = {};
      for (var item in data['data'] as List<dynamic>) {
        final market = Market.fromJson(item as Map<String, dynamic>);
        markets[market.category] = (markets[market.category] ?? []);
        markets[market.category]?.add(market);
        // Here you would typically dispatch an action to update the state with the new card
        // store.dispatch(GetTradeCardAction(cards: [card]));
      }
       return Markets(markets: markets);
    } else {
      throw Exception('Failed to load markets: ${response.statusCode}');
    }
}


class Market {
  String assetName;
  int assetPrecision;
  bool active;
  String category;
  // marketStats
  double lastPrice;
  double bidPrice;
  double askPrice;
  double dailyVolume;
  double dailyPriceChange;
  double dailyPriceChangePercentage;
  // tradingConfig
  double minOrderSize;
  double minOrderSizeChange;
  double maxMarketOrderValue;
  double maxLeverage;
  double minPriceChange;

  Market({
    required this.assetName,
    required this.assetPrecision,
    required this.active,
    required this.category,
    // marketStats
    required this.lastPrice,
    required this.bidPrice,
    required this.askPrice,
    required this.dailyVolume,
    required this.dailyPriceChange,
    required this.dailyPriceChangePercentage,
    // tradingConfig
    required this.minOrderSize,
    required this.minOrderSizeChange,
    required this.maxMarketOrderValue,
    required this.maxLeverage,
    required this.minPriceChange,
  });

  double getAssetAmount(double amount) {
    final price = max(askPrice, bidPrice);
    if (price == 0) {
      return 0;
    }
    return amount / price; // Example: 100% of sell price
  }

  static Market fromJson(Map<String, dynamic> item) {
    final marketStats = item['marketStats'] as Map<String, dynamic>;
    final tradingConfig = item['tradingConfig'] as Map<String, dynamic>;
    // Assuming item has 'asset', 'buyPrice', and 'sellPrice' fields
    final card = Market(
      assetName: item['assetName'] as String,
      assetPrecision: item['assetPrecision'] as int,
      active: item['active'] as bool,
      category: item['category'] as String,
      //
      lastPrice: double.parse(marketStats['lastPrice']) ,
      bidPrice: double.parse(marketStats['bidPrice']),
      askPrice: double.parse(marketStats['askPrice']),
      dailyVolume: double.parse(marketStats['dailyVolume']),
      dailyPriceChange: double.parse(marketStats['dailyPriceChange']),
      dailyPriceChangePercentage: double.parse(marketStats['dailyPriceChangePercentage']),
      //
      minOrderSize: double.parse(tradingConfig['minOrderSize']),
      minOrderSizeChange: double.parse(tradingConfig['minOrderSizeChange']),
      maxMarketOrderValue: double.parse(tradingConfig['maxMarketOrderValue']),
      maxLeverage: double.parse(tradingConfig['maxLeverage']),
      minPriceChange: double.parse(tradingConfig['minPriceChange']),
    );
    return card;
  }

  static Market dummy() {
    return Market(
      category: 'L1',
      assetName: 'BTC',
      assetPrecision: 4,
      active: true,
      lastPrice: 10000.0,
      bidPrice: 9999.0,
      askPrice: 10000.0,
      dailyVolume: 1000.0,
      dailyPriceChange: 5.0,
      dailyPriceChangePercentage: 5.0,
      minOrderSize: 0.01,
      minOrderSizeChange: 0.01,
      maxMarketOrderValue: 10000.0,
      maxLeverage: 10.0,
      minPriceChange: 0.01,
    );
  }
}
