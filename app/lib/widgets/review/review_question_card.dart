import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/question.dart';

class ReviewQuestionCard extends StatelessWidget {
  final Question question;
  final int questionNumber;
  final int totalCount;
  final int? selectedIndex;
  final bool isDark;

  const ReviewQuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalCount,
    required this.selectedIndex,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final correctIndex = question.correctAnswerIndex;
    final isUserCorrect = selectedIndex == correctIndex;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUserCorrect
              ? const Color(0xFF22C55E).withValues(alpha: 0.4)
              : const Color(0xFFEF4444).withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top indicator row: Q# and Correct/Wrong tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question $questionNumber of $totalCount',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF64748B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isUserCorrect
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isUserCorrect
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      size: 14,
                      color: isUserCorrect
                          ? const Color(0xFF16A34A)
                          : const Color(0xFFDC2626),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isUserCorrect ? 'Correct' : 'Wrong',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isUserCorrect
                            ? const Color(0xFF16A34A)
                            : const Color(0xFFDC2626),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Question text
          Text(
            question.questionText,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),

          // Code snippet if present
          if (question.codeSnippet != null) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2238),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                question.codeSnippet!,
                style: GoogleFonts.firaCode(
                  fontSize: 12,
                  color: const Color(0xFFE2E8F0),
                  height: 1.4,
                ),
              ),
            ),
          ],

          const SizedBox(height: 14),

          // Options List
          ...List.generate(question.options.length, (optIdx) {
            final isCorrect = optIdx == correctIndex;
            final isSelected = optIdx == selectedIndex;

            Color optBg = Colors.transparent;
            Color optBorder = isDark
                ? const Color(0xFF334155)
                : const Color(0xFFE2E8F0);
            Color optTextColor = isDark
                ? const Color(0xFFCBD5E1)
                : const Color(0xFF334155);

            if (isCorrect) {
              optBg = const Color(0xFF22C55E).withValues(alpha: 0.12);
              optBorder = const Color(0xFF22C55E);
              optTextColor = const Color(0xFF16A34A);
            } else if (isSelected) {
              optBg = const Color(0xFFEF4444).withValues(alpha: 0.12);
              optBorder = const Color(0xFFEF4444);
              optTextColor = const Color(0xFFDC2626);
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: optBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: optBorder, width: 1.2),
              ),
              child: Row(
                children: [
                  Icon(
                    isCorrect
                        ? Icons.check_circle_rounded
                        : (isSelected
                            ? Icons.cancel_rounded
                            : Icons.radio_button_unchecked),
                    size: 16,
                    color: isCorrect
                        ? const Color(0xFF16A34A)
                        : (isSelected
                            ? const Color(0xFFDC2626)
                            : (isDark
                                ? const Color(0xFF64748B)
                                : const Color(0xFF94A3B8))),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      question.options[optIdx],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: (isCorrect || isSelected)
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: optTextColor,
                      ),
                    ),
                  ),
                  if (isSelected && !isCorrect)
                    Text(
                      'Your answer',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                  if (isCorrect)
                    Text(
                      'Correct answer',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF16A34A),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
