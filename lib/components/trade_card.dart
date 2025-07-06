import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/components/trade.dart';
import 'package:namer_app/util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/bigtext.dart';
import 'painter.dart';
import '../redux/market.dart';
  Widget _buildChart(List<double> data, bool isPositive) {
    return Container(
      height: 80,
      child: CustomPaint(
        painter: ChartPainter(
          data,
          isPositive ? Color(0xFF10B981) : Color(0xFFEF4444),
        ),
        size: Size.infinite,
      ),
    );
  }

  Widget _buildAssetStats(Market asset) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatColumn('Open Interest', formatDollar(asset.openInterest)),
          _buildStatColumn('Funding Rate', formatPercent100(asset.fundingRate)),
          _buildStatColumn('24h Volume', formatDollar(asset.dailyVolume)),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: textstyle.midWhite),
        SizedBox(height: 4),
        Text(label, style: textstyle.smaller),
      ],
    );
  }

  Widget buildAssetCard(Market market,   bool isCenter) {
    double scale = isCenter ? 1.0 : 0.85;
    double opacity = isCenter ? 1.0 : 0.4;

    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.all(15),
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
                      // color: market.color.withOpacity(0.2),
                    ),
                    child: SvgPicture.network(market.imageUrl(), fit: BoxFit.cover),
                        // market.symbol,
                        // style: GoogleFonts.poppins(
                        //   fontSize: 18,
                        //   fontWeight: FontWeight.w700,
                        //   color: market.color,
                        // ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${market.bidPrice.toString()}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      _buildChangeIndicator(market.dailyPriceChangePercentage.abs()*100, market.dailyPriceChangePercentage > 0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                market.fullName,
                style: textstyle.big,
              ),
              Text(
                market.code,
                style: textstyle.midLess,
              ),
              SizedBox(height: 20),
              _buildChart([25, 40, 30, 55, 45, 60, 50, 70, 60, 75], market.dailyPriceChangePercentage > 0),
              SizedBox(height: 20),
              _buildAssetStats(market),
              SizedBox(height: 15),
              buildTradeButtons(),
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
        color: (isPositive ? Color(0xFF10B981) : Color(0xFFEF4444)).withOpacity(
          0.2,
        ),
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