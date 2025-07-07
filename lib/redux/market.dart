import 'package:flutter/material.dart';
import 'package:finroit/redux/const.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:math';
import 'dart:developer' as dev;
part 'market.g.dart';

void combine(Map<String, List<Market>> markets, Map<String, String> names) {
  for (var category in markets.keys) {
    for (var market in markets[category] ?? List<Market>.from([])) {
      if (names.containsKey(market.code)) {
        market.fullName = names[market.code] ?? 'Nan';
      }
    }
  }
}

@riverpod
class Markets extends _$Markets {
  final Map<String, List<Market>> markets;
  final List<String> categories;

  Markets({this.markets = const {}, this.categories = const []});

  List<Market> getMarketsByCategory(String category) {
    return markets[category] ?? [];
  }

  List<String> getCategories() {
    return markets.keys.toList();
  }

  @override
  Markets build() {
    Map<String, List<Market>> markets = {
      'L1': [Market.dummy(asset: 'KAITO'), Market.dummy(), Market.dummy()],
      'L2': [
        Market.dummy(asset: 'ETH'),
        // Market.dummy(asset: 'SONIC'),
        Market.dummy(asset: 'KAITO'),
        Market.dummy(asset: 'BNB'),
        Market.dummy(asset: 'XAU'),
      ],
    };
    combine(markets, {
      'BTC': 'Bitcoin',
      'ETH': 'Ethereum',
      'BNB': 'Binance Coin',
      'XAU': 'Gold',
      'SONIC': 'Sonic',
      'KAITO': 'kaito',
    });
    return Markets(markets: markets, categories: ['L1', 'L2']);
  }

  update() async {
    dev.log('Updating market state');
    final newMarkets = await fetchMarket();
    final extraDetails = await fetchextraDetails();
    combine(newMarkets.markets, extraDetails);
    state = newMarkets;
  }

  Future<Markets> fetchMarket() async {
    // This is a placeholder for the market data.
    // In a real application, you would fetch this data from an API or database.
    final response = await http.get(
      Uri.parse('${Constants.extendedApiBaseUrl}/api/v1/info/markets'),
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
      var keys = markets.keys.toList();
      keys.sort(
        (a, b) => (markets[a]?.length ?? 0).compareTo(markets[b]?.length ?? 0),
      );
      return Markets(markets: markets, categories: keys);
    } else {
      throw Exception('Failed to load markets: ${response.statusCode}');
    }
  }
}

Future<Map<String, String>> fetchextraDetails() async {
  final response = await http.get(
    Uri.parse('${Constants.backendApiUrl}/market/extra'),
  );
  if (response.statusCode == 200) {
    final dynamic data = jsonDecode(response.body);
    final Map<String, String> names = {};
    (data as Map<String, dynamic>).forEach((sym, value) {
      names[sym] = (value as Map<String, dynamic>)['name'] as String;
    });
    return names;
  } else {
    throw Exception('Failed to load markets: ${response.statusCode}');
  }
}

class Market {
  String code;
  int assetPrecision;
  bool active;
  String category;
  // marketStats
  double lastPrice;
  double bidPrice;
  double askPrice;
  double dailyVolume;
  double dailyPriceChange;
  double fundingRate;
  double openInterest;
  double dailyPriceChangePercentage;
  // tradingConfig
  double minOrderSize;
  double minOrderSizeChange;
  double maxMarketOrderValue;
  double maxLeverage;
  double minPriceChange;

  // Color color;
  // String symbol;
  String fullName;

  String notion(double x) {
    if (x > 1_000_000_000_000) {
      return '${(x / 1_000_000_000_000).toStringAsFixed(2)}T';
    } else if (x > 1_000_000_000) {
      return '${(x / 1_000_000_000).toStringAsFixed(2)}B';
    } else if (x > 1_000_000_000) {
      return '${(x / 1_000_000_000).toStringAsFixed(2)}B';
    } else if (x > 1_000_000) {
      return '${(x / 1_000_000).toStringAsFixed(2)}M';
    } else if (x > 1_000) {
      return '${(x / 1_000).toStringAsFixed(2)}K';
    } else {
      return x.toStringAsFixed(2);
    }
  }

  Market({
    required this.code,
    required this.assetPrecision,
    required this.active,
    required this.category,
    // marketStats
    required this.lastPrice,
    required this.bidPrice,
    required this.askPrice,
    required this.dailyVolume,
    required this.dailyPriceChange,
    required this.fundingRate,
    required this.openInterest,
    required this.dailyPriceChangePercentage,
    // tradingConfig
    required this.minOrderSize,
    required this.minOrderSizeChange,
    required this.maxMarketOrderValue,
    required this.maxLeverage,
    required this.minPriceChange,

    // this.color = const Color(0xFfFFFFFF),
    // this.symbol = '',
    this.fullName = '',
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
      code: item['assetName'] as String,
      assetPrecision: item['assetPrecision'] as int,
      active: item['active'] as bool,
      category: item['category'] as String,
      //
      lastPrice: double.parse(marketStats['lastPrice']),
      bidPrice: double.parse(marketStats['bidPrice']),
      askPrice: double.parse(marketStats['askPrice']),
      dailyVolume: double.parse(marketStats['dailyVolume']),
      fundingRate: double.parse(marketStats['fundingRate'] ?? '0.0'),
      openInterest: double.parse(marketStats['openInterest'] ?? '0.0'),
      dailyPriceChange: double.parse(marketStats['dailyPriceChange']),
      dailyPriceChangePercentage: double.parse(
        marketStats['dailyPriceChangePercentage'],
      ),
      //
      minOrderSize: double.parse(tradingConfig['minOrderSize']),
      minOrderSizeChange: double.parse(tradingConfig['minOrderSizeChange']),
      maxMarketOrderValue: double.parse(tradingConfig['maxMarketOrderValue']),
      maxLeverage: double.parse(tradingConfig['maxLeverage']),
      minPriceChange: double.parse(tradingConfig['minPriceChange']),
    );
    return card;
  }
  String imageUrl() {
    dev.log('https://cdn.extended.exchange/crypto/${this.code}.svg');
    return 'https://cdn.extended.exchange/crypto/${this.code}.svg';
  }
  static Market dummy({String asset = 'BTC'}) {
    return Market(
      category: 'L1',
      code: asset,
      assetPrecision: 4,
      active: true,
      lastPrice: 10000.0,
      bidPrice: 9999.0,
      askPrice: 10000.0,
      dailyVolume: 1000.0,
      fundingRate: 0.00001,
      openInterest: 500.0,
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
