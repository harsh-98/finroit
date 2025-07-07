import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finroit/components/category_tab.dart';
import 'package:finroit/components/deck.dart';
import 'package:finroit/components/header.dart';
import 'package:finroit/components/trade.dart';
import 'package:finroit/components/trade_card.dart';
import 'package:finroit/redux/nav_bar_index.dart';
import 'package:finroit/redux/user.dart';
import 'package:finroit/utils/bigtext.dart';
import '../redux/market.dart';
import '../components/nav_bar.dart';

class TradingScaffold extends ConsumerStatefulWidget {
  const TradingScaffold({super.key});

  @override
  ConsumerState<TradingScaffold> createState() => _TradingScaffoldState();
}

class _TradingScaffoldState extends ConsumerState<TradingScaffold> {
  @override
  void initState() {
    super.initState();
    ref.read(userStateProvider.notifier).update();
    ref.read(marketsProvider.notifier).update();
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
                  CategoryTab(),
                  SizedBox(height: 16),
                  Deck(),
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

  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Text('Trade Assets', style: textstyle.bigger)]),
          SizedBox(height: 8),
          Text(
            'Swipe to explore different assets',
            style: textstyle.midLess,
          ),
        ],
      ),
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

