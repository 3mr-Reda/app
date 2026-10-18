import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ReviewFilter { all, wrong, correct }

class ReviewFilterTabs extends StatelessWidget {
  final ReviewFilter currentFilter;
  final int totalCount;
  final int wrongCount;
  final int correctCount;
  final bool isDark;
  final ValueChanged<ReviewFilter> onFilterChanged;

  const ReviewFilterTabs({
    super.key,
    required this.currentFilter,
    required this.totalCount,
    required this.wrongCount,
    required this.correctCount,
    required this.isDark,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E293B)
              : const Color(0xFFE2E8F0).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _buildTabItem(
              label: 'All ($totalCount)',
              filter: ReviewFilter.all,
            ),
            _buildTabItem(
              label: 'Wrong ($wrongCount)',
              filter: ReviewFilter.wrong,
              activeColor: const Color(0xFFEF4444),
            ),
            _buildTabItem(
              label: 'Correct ($correctCount)',
              filter: ReviewFilter.correct,
              activeColor: const Color(0xFF22C55E),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required String label,
    required ReviewFilter filter,
    Color? activeColor,
  }) {
    final isSelected = currentFilter == filter;
    final color = activeColor ?? const Color(0xFF5B5BF0);

    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(filter),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF334155) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected
                  ? color
                  : (isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF64748B)),
            ),
          ),
        ),
      ),
    );
  }
}
