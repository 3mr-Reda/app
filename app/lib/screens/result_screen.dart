import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../services/app_settings.dart';
import '../widgets/result/celebration_painter.dart';
import '../widgets/result/circular_score_gauge.dart';
import '../widgets/result/result_action_buttons.dart';
import '../widgets/result/result_stat_card.dart';
import 'quiz_screen.dart';
import 'review_answers_screen.dart';

class ResultScreen extends StatelessWidget {
  final QuizCategory category;

  const ResultScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = quiz.totalQuestions;
    final correct = quiz.correctAnswers;
    final wrong = quiz.wrongAnswers;
    final percent = quiz.percentage.round();

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 24,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 12),

                        // 1. Celebration Illustration with Confetti & Happy Character
                        const SizedBox(
                          width: 220,
                          height: 160,
                          child: CustomPaint(
                            painter: CelebrationPainter(),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // 2. Title & Subtitle
                        Text(
                          "Time's Up!",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'You answered all the questions',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // 3. Circular Progress Gauge (8/10, 80%)
                        CircularScoreGauge(
                          correct: correct,
                          total: total,
                          percentage: percent,
                          isDark: isDark,
                        ),

                        const SizedBox(height: 28),

                        // 4. Correct Card (Tap to view correct questions)
                        ResultStatCard(
                          isDark: isDark,
                          icon: Icons.check,
                          iconBgColor: const Color(0xFF22C55E),
                          label: 'Correct',
                          value: '$correct',
                          onTap: () {
                            AppSettings.instance.triggerHaptic();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReviewAnswersScreen(
                                  category: category,
                                  initialFilter: ReviewFilter.correct,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        // 5. Wrong Card (Tap to view wrong questions)
                        ResultStatCard(
                          isDark: isDark,
                          icon: Icons.close,
                          iconBgColor: const Color(0xFFEF4444),
                          label: 'Wrong',
                          value: '$wrong',
                          onTap: () {
                            AppSettings.instance.triggerHaptic();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReviewAnswersScreen(
                                  category: category,
                                  initialFilter: ReviewFilter.wrong,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 8),

                        // Hint text
                        Text(
                          'Tap on Wrong or Correct to review questions',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFF64748B)
                                : const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),

                    // 6. Action Buttons at the Bottom
                    ResultActionButtons(
                      isDark: isDark,
                      primaryLabel: 'Try Again',
                      onPrimaryPressed: () {
                        AppSettings.instance.triggerHaptic();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(category: category),
                          ),
                        );
                      },
                      secondaryLabel: 'Home',
                      onSecondaryPressed: () {
                        AppSettings.instance.triggerHaptic();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
