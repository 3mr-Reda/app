import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/quiz_category.dart';
import 'info_pill.dart';

class CategoryHeroCard extends StatelessWidget {
  final QuizCategory category;

  const CategoryHeroCard({
    super.key,
    required this.category,
  });

  Widget _buildCategoryIcon() {
    if (category.isFlutter) {
      return ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: const FlutterLogo(size: 32),
      );
    }
    return Icon(
      category.icon ?? Icons.quiz_outlined,
      color: Colors.white,
      size: 32,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 28,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF1E293B),
                  const Color(0xFF1E293B).withValues(alpha: 0.8),
                ]
              : [
                  const Color(0xFFEFF5FF),
                  const Color(0xFFE8F0FE),
                ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category Icon Badge
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: category.color,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: category.color.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: _buildCategoryIcon(),
          ),

          const SizedBox(height: 16),

          // Title
          Text(
            category.displayTitle,
            style: GoogleFonts.urbanist(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle
          Text(
            category.subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 18),

          // Pills Row
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              InfoPill(
                icon: Icons.error_outline_rounded,
                label: '${category.questionCount} Questions',
              ),
              InfoPill(
                icon: Icons.calendar_today_outlined,
                label: '${category.durationMinutes} Minutes',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
