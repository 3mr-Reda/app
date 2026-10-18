import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizTopBar extends StatelessWidget {
  final int currentQuestionIndex;
  final int totalQuestions;
  final int secondsRemaining;
  final bool isDark;

  const QuizTopBar({
    super.key,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.secondsRemaining,
    required this.isDark,
  });

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final isDanger = secondsRemaining <= 10;
    final timerColor = isDanger ? const Color(0xFFEF4444) : const Color(0xFF5B5BF0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Question Counter: e.g. "3/10"
          Text(
            '${currentQuestionIndex + 1}/$totalQuestions',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),

          // Timer Pill Badge: e.g. "01:12"
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F1FE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 15,
                  color: timerColor,
                ),
                const SizedBox(width: 6),
                Text(
                  _formatTime(secondsRemaining),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: timerColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
