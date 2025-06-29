import 'dart:math';

class Market {
  String assetName;
  int assetPrecision;
  bool active;
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
