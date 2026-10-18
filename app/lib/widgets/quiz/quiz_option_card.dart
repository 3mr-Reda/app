import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizOptionCard extends StatelessWidget {
  final bool isDark;
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const QuizOptionCard({
    super.key,
    required this.isDark,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark
        ? const Color(0xFF1E293B)
        : Colors.white;

    final borderColor = isSelected
        ? const Color(0xFF22C55E)
        : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0));

    final textColor = isDark
        ? Colors.white
        : const Color(0xFF1E293B);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2.0 : 1.5,
          ),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF22C55E).withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          children: [
            // Left Radio Indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF22C55E)
                      : (isDark
                          ? const Color(0xFF475569)
                          : const Color(0xFFCBD5E1)),
                  width: 2.0,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 14),

            // Option Text
            Expanded(
              child: Text(
                optionText,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),

            // Right Checkmark Icon (Only when selected)
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                size: 22,
                color: Color(0xFF22C55E),
              ),
          ],
        ),
      ),
    );
  }
}
