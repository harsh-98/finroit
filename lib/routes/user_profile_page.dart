import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // Top banner section
                Container(
                  width: double.infinity,
                  height: 94,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFF4338CA), Color(0xFF3B82F6)],
                    ),
                  ),
                ),
                // Main content
                _buildMainContent(),
              ],
            ),
            // Header overlay
            _buildHeader(),
            // Floating action button
            _buildFloatingActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 72,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // User level badge
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'LV8',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // User info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'TraderJoe',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      '2,340 XP',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Action buttons
            Row(
              children: [
                _buildActionButton(Icons.people_outline),
                const SizedBox(width: 12),
                _buildActionButton(Icons.notifications_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF1F2937),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Stats cards section
          _buildStatsCards(),
          const SizedBox(height: 16),
          // NFTs section
          _buildNFTsSection(),
          const SizedBox(height: 16),
          // Hot Markets section
          _buildHotMarketsSection(),
          const SizedBox(height: 100), // Space for floating button
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Row(
      children: [
        // Portfolio card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF1F2937),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Portfolio',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$1,240',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '+\$24 today',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4ADE80),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Win Streak card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF1F2937),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Win Streak',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 8),
                _buildWinStreakDots(),
                const SizedBox(height: 8),
                const Text(
                  '3 days',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4ADE80),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Clan Rank card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF1F2937),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clan Rank',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '#4',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Diamond',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF60A5FA),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWinStreakDots() {
    return Row(
      children: List.generate(5, (index) {
        final isActive = index < 3; // 3 active dots for 3-day streak
        return Container(
          margin: const EdgeInsets.only(right: 3),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? const Color(0xFF10B981)
                : Colors.white.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  Widget _buildNFTsSection() {
    return Column(
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your NFTs',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const Text(
              'View All',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF60A5FA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // NFT items
        Row(
          children: [
            _buildNFTItem(Icons.add, const Color(0xFFEAB308)),
            const SizedBox(width: 12),
            _buildNFTItem(Icons.check_circle, const Color(0xFF22C55E)),
            const SizedBox(width: 12),
            _buildNFTItem(Icons.view_in_ar, const Color(0xFF3B82F6)),
            const SizedBox(width: 12),
            _buildNFTItem(Icons.local_fire_department, const Color(0xFFA855F7)),
            const SizedBox(width: 12),
            _buildNFTItem(Icons.add, const Color(0xFF9CA3AF), opacity: 0.5),
          ],
        ),
      ],
    );
  }

  Widget _buildNFTItem(IconData icon, Color color, {double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: 64,
        height: 64,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: color,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildHotMarketsSection() {
    return Column(
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hot Markets',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const Text(
              'Explore',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF60A5FA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Market items
        Column(
          children: [
            _buildMarketItem(
              'BTC',
              'Bitcoin',
              '\$42,350',
              '+2.4%',
              const Color(0xFF3B82F6),
              true,
            ),
            const SizedBox(height: 8),
            _buildMarketItem(
              'ETH',
              'Ethereum',
              '\$2,850',
              '-1.2%',
              const Color(0xFF1D4ED8),
              false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMarketItem(
    String symbol,
    String name,
    String price,
    String change,
    Color iconColor,
    bool isPositive,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF1F2937),
      ),
      child: Row(
        children: [
          // Crypto icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor,
            ),
            child: Center(
              child: Text(
                symbol,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Crypto info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          // Price change
          Text(
            change,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isPositive ? const Color(0xFF4ADE80) : const Color(0xFFF87171),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEC4899), Color(0xFF8B5CF6)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEC4899).withOpacity(0.5),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.visibility_off,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
