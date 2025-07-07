import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finroit/components/level_indicator.dart';
import 'package:finroit/components/achievement_badge.dart';

class LeaderboardUserItem extends StatelessWidget {
  final int rank;
  final String initials;
  final String name;
  final String xp;
  final String level;
  final int progressDots;
  final String achievement;
  final Color achievementColor;
  final bool isCurrentUser;
  final bool hasHome;

  const LeaderboardUserItem({
    super.key,
    required this.rank,
    required this.initials,
    required this.name,
    required this.xp,
    required this.level,
    required this.progressDots,
    required this.achievement,
    required this.achievementColor,
    this.isCurrentUser = false,
    this.hasHome = false,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isCurrentUser ? 13 : 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1E293B),
        border: isCurrentUser
            ? Border.all(color: const Color(0xFF6366F1), width: 1)
            : null,
        gradient: isCurrentUser
            ? LinearGradient(
                colors: [
                  const Color(0xFF312E81).withOpacity(0.2),
                  Colors.transparent,
                ],
              )
            : null,
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isCurrentUser
                  ? const Color(0xFF4F46E5)
                  : const Color(0xFF374151),
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
          const SizedBox(width: 12),

          // User avatar
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
          const SizedBox(width: 12),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and XP row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      xp,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isCurrentUser
                            ? const Color(0xFFA5B4FC)
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Level and achievement row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LevelIndicator(
                          level: level,
                          isCurrentUser: isCurrentUser,
                        ),
                        const SizedBox(width: 8),
                        _buildProgressDots(),
                      ],
                    ),
                    Row(
                      children: [
                        AchievementBadge(
                          letter: achievement,
                          color: achievementColor,
                        ),
                        if (hasHome) ...[
                          const SizedBox(width: 4),
                          Container(
                            width: 24,
                            height: 24,
                            child: Stack(
                              children: [
                                Icon(
                                  Icons.home,
                                  color: const Color(0xFF8B5CF6),
                                  size: 24,
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 6,
                                  right: 6,
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6D28D9),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressDots() {
    return Row(
      children: List.generate(4, (index) {
        final isActive = index < progressDots;
        return Container(
          margin: const EdgeInsets.only(right: 2),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: isActive
                ? const Color(0xFF10B981)
                : Colors.white.withOpacity(0.3),
          ),
        );
      }),
    );
  }
}
