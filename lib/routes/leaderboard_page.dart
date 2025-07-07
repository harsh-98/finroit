import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finroit/components/leaderboard_user_item.dart';
import 'package:finroit/components/level_indicator.dart';
import 'package:finroit/components/achievement_badge.dart';
import '../utils/bigtext.dart' ;

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  String selectedTab = 'Global';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Column(
        children: [
          // Header Section
          _buildHeader(),

          // Leaderboard Card
          _buildLeaderboardCard(),

          // Top 3 Users Podium
          _buildTopThreeUsers(),

          // Ranked List
          Expanded(
            child: _buildRankedList(),
          ),


        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // User Level Badge
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
                  ),
                ),
                child: Center(
                  child: Text(
                    'LV8',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
          Row(
            children: [
              _buildHeaderButton(Icons.group),
              const SizedBox(width: 12),
              _buildHeaderButton(Icons.notifications),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1F2937),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildLeaderboardCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4338CA), Color(0xFF3B82F6)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Leaderboard',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildTabButton('Global', selectedTab == 'Global'),
                const SizedBox(width: 8),
                _buildTabButton('Friends', selectedTab == 'Friends'),
                const SizedBox(width: 8),
                _buildTabButton('Clan', selectedTab == 'Clan'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'This Week',
                  style: textstyle.smallLess,
                ),
                Row(
                  children: [
                     Text(
                      'Filter',
                      style: textstyle.smallWhite,
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTopThreeUsers() {
    return Container(
      height: 104,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Second place
          Expanded(
            child: _buildPodiumUser(
              'JD',
              'JaneDoe',
              '8,240 XP',
              2,
              const Color(0xFF94A3B8),
              48,
            ),
          ),
          // First place (taller)
          Expanded(
            child: _buildPodiumUser(
              'KL',
              'KingLion',
              '12,450 XP',
              1,
              const Color(0xFFF59E0B),
              64,
              hasGoldBorder: true,
              hasCrown: true,
            ),
          ),
          // Third place
          Expanded(
            child: _buildPodiumUser(
              'MJ',
              'MasterJ',
              '7,890 XP',
              3,
              const Color(0xFFB45309),
              48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumUser(
    String initials,
    String name,
    String xp,
    int rank,
    Color rankColor,
    double avatarSize, {
    bool hasGoldBorder = false,
    bool hasCrown = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (hasCrown)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Transform.rotate(
              angle: 0.26, // 15 degrees
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B),
                ),
                child: CustomPaint(
                  painter: CrownPainter(),
                ),
              ),
            ),
          ),
        Container(
          width: avatarSize,
          height: avatarSize,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(avatarSize / 2),
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFFA855F7)],
            ),
            border: hasGoldBorder
                ? Border.all(color: const Color(0xFFEAB308), width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              initials,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: avatarSize == 64 ? 14 : 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: rank == 1
                      ? [const Color(0xFFF59E0B), const Color(0xFFFBBF24)]
                      : rank == 2
                          ? [const Color(0xFF94A3B8), const Color(0xFFCBD5E1)]
                          : [const Color(0xFFB45309), const Color(0xFFD97706)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: rankColor.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  rank.toString(),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              xp,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRankedList() {
    final users = [
      {
        'rank': 4,
        'initials': 'TS',
        'name': 'TraderSam',
        'xp': '7,120 XP',
        'level': 'LV7',
        'progressDots': 2,
        'achievement': 'A',
        'achievementColor': Color(0xFFEF4444),
      },
      {
        'rank': 5,
        'initials': 'CK',
        'name': 'CryptoKing',
        'xp': '6,950 XP',
        'level': 'LV7',
        'progressDots': 4,
        'achievement': 'B',
        'achievementColor': Color(0xFF3B82F6),
      },
      {
        'rank': 6,
        'initials': 'TJ',
        'name': 'TraderJoe',
        'xp': '6,340 XP',
        'level': 'LV6',
        'progressDots': 3,
        'achievement': 'D',
        'achievementColor': Color(0xFFA855F7),
        'isCurrentUser': true,
        'hasHome': true,
      },
      {
        'rank': 7,
        'initials': 'BT',
        'name': 'BitTrader',
        'xp': '5,980 XP',
        'level': 'LV6',
        'progressDots': 1,
        'achievement': 'C',
        'achievementColor': Color(0xFF22C55E),
      },
      {
        'rank': 8,
        'initials': 'ET',
        'name': 'EthTrader',
        'xp': '5,740 XP',
        'level': 'LV6',
        'progressDots': 2,
        'achievement': 'A',
        'achievementColor': Color(0xFFEAB308),
      },
      {
        'rank': 9,
        'initials': 'MC',
        'name': 'MoonCoin',
        'xp': '5,320 XP',
        'level': 'LV5',
        'progressDots': 1,
        'achievement': 'E',
        'achievementColor': Color(0xFFEC4899),
      },
      {
        'rank': 10,
        'initials': 'DT',
        'name': 'DayTrader',
        'xp': '4,980 XP',
        'level': 'LV5',
        'progressDots': 3,
        'achievement': 'B',
        'achievementColor': Color(0xFFF97316),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 180), // Add padding for floating action button
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return LeaderboardUserItem(
            rank: user['rank'] as int,
            initials: user['initials'] as String,
            name: user['name'] as String,
            xp: user['xp'] as String,
            level: user['level'] as String,
            progressDots: user['progressDots'] as int,
            achievement: user['achievement'] as String,
            achievementColor: user['achievementColor'] as Color,
            isCurrentUser: user['isCurrentUser'] as bool? ?? false,
            hasHome: user['hasHome'] as bool? ?? false,
          );
        },
      ),
    );
  }


}

class CrownPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.1, size.height * 0.4);
    path.lineTo(size.width * 0.3, size.height * 0.6);
    path.lineTo(size.width * 0.5, size.height * 0.2);
    path.lineTo(size.width * 0.7, size.height * 0.6);
    path.lineTo(size.width * 0.9, size.height * 0.4);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
