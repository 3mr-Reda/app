import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'review_filter_tabs.dart';

class ReviewEmptyState extends StatelessWidget {
  final ReviewFilter currentFilter;
  final bool isDark;

  const ReviewEmptyState({
    super.key,
    required this.currentFilter,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final isWrong = currentFilter == ReviewFilter.wrong;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isWrong ? Icons.emoji_events_rounded : Icons.info_outline_rounded,
              size: 56,
              color: isWrong
                  ? const Color(0xFF22C55E)
                  : const Color(0xFF64748B),
            ),
            const SizedBox(height: 14),
            Text(
              isWrong
                  ? 'No wrong questions! Perfect score!'
                  : 'No questions found.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
