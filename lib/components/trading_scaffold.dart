import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/components/header.dart';
import 'package:namer_app/redux/user.dart';
import '../redux/market.dart';
import 'nav_bar.dart';

class TradingScaffold extends ConsumerStatefulWidget {
  const TradingScaffold({super.key});

  @override
  ConsumerState<TradingScaffold> createState() => _TradingScaffoldState();
}

class _TradingScaffoldState extends ConsumerState<TradingScaffold> {
  PageController _pageController = PageController();
  int _selectedTabIndex = 0;
  int _currentCardIndex = 2; // Tesla card is in focus (index 2)
  int _currentBottomIndex = 2; // Portfolio tab active

  final List<String> _assetCategories = [
    'All Assets',
    'Crypto', 
    'Stocks',
    'Commodities',
    'Forex'
  ];

  // Sample asset data matching the design
  final List<AssetCardData> _assets = [
    AssetCardData(
      symbol: '₿',
      name: 'Bitcoin',
      code: 'BTC',
      price: 42350.0,
      change: 2.4,
      isPositive: true,
      marketCap: '820B',
      volume: '24.5B',
      supply: '21M',
      color: Color(0xFFF97316),
      chartData: [30, 45, 35, 50, 40, 60, 45, 70, 55, 75],
    ),
    AssetCardData(
      symbol: 'Au',
      name: 'Gold',
      code: 'XAU',
      price: 1845.0,
      change: 1.2,
      isPositive: true,
      marketCap: '12T',
      volume: '85B',
      supply: 'Limited',
      color: Color(0xFFEAB308),
      chartData: [40, 30, 45, 35, 50, 40, 60, 45, 55, 50],
    ),
    AssetCardData(
      symbol: 'Ξ',
      name: 'Ethereum',
      code: 'ETH',
      price: 2850.0,
      change: -1.2,
      isPositive: false,
      marketCap: '340B',
      volume: '18.2B',
      supply: '120M',
      color: Color(0xFF3B82F6),
      chartData: [60, 45, 30, 50, 35, 25, 40, 30, 45, 35],
    ),
    AssetCardData(
      symbol: 'A',
      name: 'Apple',
      code: 'AAPL',
      price: 182.75,
      change: 0.8,
      isPositive: true,
      marketCap: '2.8T',
      volume: '8.5B',
      supply: '16.5B',
      color: Color(0xFFD1D5DB),
      chartData: [20, 35, 25, 40, 30, 45, 35, 50, 40, 55],
    ),
    AssetCardData(
      symbol: 'T',
      name: 'Tesla',
      code: 'TSLA',
      price: 248.50,
      change: 3.8,
      isPositive: true,
      marketCap: '780B',
      volume: '12.4B',
      supply: '3.2B',
      color: Color(0xFFEF4444),
      chartData: [25, 40, 30, 55, 45, 60, 50, 70, 60, 75],
    ),
  ];

  @override
  void initState() {
    super.initState();
    ref.read(userStateProvider.notifier).update();
    ref.read(marketsProvider.notifier).update();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          children: [
            Header(userState: ref.watch(userStateProvider)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTitleSection(),
                    _buildCategoryTabs(),
                    SizedBox(height: 16),
                    _buildAssetCards(),
                    SizedBox(height: 16),
                    _buildPortfolioSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }


  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF1F2937),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Trade Assets',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Swipe to explore different assets',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 44,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _assetCategories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == _selectedTabIndex;
          return Container(
            margin: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? Color(0xFF4F46E5) : Color(0xFF1F2937),
                ),
                child: Text(
                  _assetCategories[index],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAssetCards() {
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
          PageView.builder(
            controller: _pageController,
            itemCount: _assets.length,
            onPageChanged: (index) {
              setState(() {
                _currentCardIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildAssetCard(_assets[index], index == _currentCardIndex);
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
              if (_currentCardIndex < _assets.length - 1) {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }),
          ),
        ],
      ),
    );
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

  Widget _buildAssetCard(AssetCardData asset, bool isCenter) {
    double scale = isCenter ? 1.0 : 0.85;
    double opacity = isCenter ? 1.0 : 0.4;
    
    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          padding: EdgeInsets.all(21),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2E3C57), Color(0xFF1E293B)],
            ),
            border: Border.all(
              color: Color(0xFF6366F1).withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF4F46E5).withOpacity(0.2),
                blurRadius: 35,
                offset: Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: asset.color.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Text(
                        asset.symbol,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: asset.color,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${asset.price.toStringAsFixed(asset.price < 100 ? 2 : 0)}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      _buildChangeIndicator(asset.change, asset.isPositive),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                asset.name,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                asset.code,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 20),
              _buildChart(asset.chartData, asset.isPositive),
              SizedBox(height: 20),
              _buildAssetStats(asset),
              SizedBox(height: 20),
              _buildTradeButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeIndicator(double change, bool isPositive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: (isPositive ? Color(0xFF10B981) : Color(0xFFEF4444)).withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            size: 12,
            color: isPositive ? Color(0xFF10B981) : Color(0xFFEF4444),
          ),
          SizedBox(width: 4),
          Text(
            '${isPositive ? '+' : ''}${change.toStringAsFixed(1)}%',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isPositive ? Color(0xFF10B981) : Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<double> data, bool isPositive) {
    return Container(
      height: 80,
      child: CustomPaint(
        painter: ChartPainter(data, isPositive ? Color(0xFF10B981) : Color(0xFFEF4444)),
        size: Size.infinite,
      ),
    );
  }

  Widget _buildAssetStats(AssetCardData asset) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatColumn('Market Cap', asset.marketCap),
          _buildStatColumn('24h Volume', asset.volume),
          _buildStatColumn(asset.code == 'AAPL' || asset.code == 'TSLA' ? 'Shares' : 'Supply', asset.supply),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '\$${value}',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildTradeButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF10B981).withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'BUY',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 41,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFEF4444).withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'SELL',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioSection() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1F2937),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Page indicators
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                bool isActive = index == 2; // Tesla card active
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isActive ? Color(0xFF6366F1) : Colors.white.withOpacity(0.3),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Your Portfolio',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'View All',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF60A5FA),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Total Value',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '\$12,450',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    _buildPortfolioButton('Deposit', Color(0xFF374151)),
                    SizedBox(width: 8),
                    _buildPortfolioButton('Withdraw', Color(0xFF4F46E5)),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '+\$340 (2.8%) today',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4ADE80),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioButton(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

}

class AssetCardData {
  final String symbol;
  final String name;
  final String code;
  final double price;
  final double change;
  final bool isPositive;
  final String marketCap;
  final String volume;
  final String supply;
  final Color color;
  final List<double> chartData;

  AssetCardData({
    required this.symbol,
    required this.name,
    required this.code,
    required this.price,
    required this.change,
    required this.isPositive,
    required this.marketCap,
    required this.volume,
    required this.supply,
    required this.color,
    required this.chartData,
  });
}

class ChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  ChartPainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final stepX = size.width / (data.length - 1);
    final maxY = data.reduce((a, b) => a > b ? a : b);
    final minY = data.reduce((a, b) => a < b ? a : b);
    final rangeY = maxY - minY;

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - ((data[i] - minY) / rangeY) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
