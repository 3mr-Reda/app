import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryAboutSection extends StatelessWidget {
  final String aboutText;

  const CategoryAboutSection({
    super.key,
    required this.aboutText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About this quiz',
          style: GoogleFonts.urbanist(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          aboutText,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            height: 1.55,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
