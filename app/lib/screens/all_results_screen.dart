import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../services/app_settings.dart';
import '../widgets/all_results/category_breakdown_item.dart';
import '../widgets/all_results/trophy_confetti_painter.dart';
import '../widgets/result/circular_score_gauge.dart';
import '../widgets/result/result_action_buttons.dart';
import '../widgets/result/result_stat_card.dart';
import 'review_answers_screen.dart';

class AllResultsScreen extends StatelessWidget {
  final VoidCallback onGoHome;
  final VoidCallback onGoToQuizzes;

  const AllResultsScreen({
    super.key,
    required this.onGoHome,
    required this.onGoToQuizzes,
  });

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final total = quiz.overallTotalQuestions;
    final correct = quiz.overallCorrectAnswers;
    final wrong = quiz.overallWrongAnswers;
    final percent = quiz.overallPercentage.round();
    final completedResults = quiz.completedResults;

    return LayoutBuilder(
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
                    const SizedBox(height: 10),

                    // 1. Golden Trophy with Confetti Illustration
                    const SizedBox(
                      width: 220,
                      height: 150,
                      child: CustomPaint(
                        painter: TrophyWithConfettiPainter(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 2. Title & Subtitle (Matching 5. Result Screen - Quizzy)
                    Text(
                      'Great Job!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'You completed the quiz',
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

                    // 4. Correct Answers Card
                    ResultStatCard(
                      isDark: isDark,
                      icon: Icons.check,
                      iconBgColor: const Color(0xFF22C55E),
                      label: 'Correct Answers',
                      value: '$correct',
                      onTap: () {
                        AppSettings.instance.triggerHaptic();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewAnswersScreen(
                              category: QuizCategory.sampleCategories.first,
                              initialFilter: ReviewFilter.correct,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // 5. Wrong Answers Card
                    ResultStatCard(
                      isDark: isDark,
                      icon: Icons.close,
                      iconBgColor: const Color(0xFFEF4444),
                      label: 'Wrong Answers',
                      value: '$wrong',
                      onTap: () {
                        AppSettings.instance.triggerHaptic();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewAnswersScreen(
                              category: QuizCategory.sampleCategories.first,
                              initialFilter: ReviewFilter.wrong,
                            ),
                          ),
                        );
                      },
                    ),

                    // 6. Category breakdown list if more than 1 category completed
                    if (completedResults.length > 1) ...[
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Category Breakdown',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? const Color(0xFFCBD5E1)
                                : const Color(0xFF475569),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...completedResults.values.map((res) {
                        return CategoryBreakdownItem(
                          result: res,
                          isDark: isDark,
                        );
                      }),
                    ],
                  ],
                ),

                // 7. Action Buttons (Try Again / Home)
                ResultActionButtons(
                  isDark: isDark,
                  primaryLabel: 'Try Again',
                  onPrimaryPressed: () {
                    AppSettings.instance.triggerHaptic();
                    onGoToQuizzes();
                  },
                  secondaryLabel: 'Home',
                  onSecondaryPressed: () {
                    AppSettings.instance.triggerHaptic();
                    onGoHome();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
