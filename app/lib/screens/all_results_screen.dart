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

  Future<void> _confirmReset(BuildContext context, QuizProvider quiz) async {
    AppSettings.instance.triggerHaptic();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reset All Results?',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        content: Text(
          'This will clear all your exam scores and reset this screen back to empty.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Reset',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldReset == true) {
      quiz.clearAllResults();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Results reset to empty.'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Widget _buildEmptyState(BuildContext context, bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 32,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 28),

                    // Elegant Empty Badge Illustration
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFEEF2FF),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFC7D2FE),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5B5BF0).withValues(alpha: 0.14),
                            blurRadius: 28,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.emoji_events_outlined,
                        size: 64,
                        color: isDark
                            ? const Color(0xFF818CF8)
                            : const Color(0xFF4F46E5),
                      ),
                    ),

                    const SizedBox(height: 26),

                    // Empty Title
                    Text(
                      'No Quiz Results Yet',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your score, accuracy, and answers will appear\nhere once you start taking exams.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Zero metrics summary card
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.25)
                                : const Color(0xFF0F172A).withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildMetricItem(
                            label: 'Quizzes',
                            value: '0',
                            isDark: isDark,
                            color: const Color(0xFF6366F1),
                          ),
                          _buildVerticalDivider(isDark),
                          _buildMetricItem(
                            label: 'Score',
                            value: '0 / 0',
                            isDark: isDark,
                            color: const Color(0xFF10B981),
                          ),
                          _buildVerticalDivider(isDark),
                          _buildMetricItem(
                            label: 'Accuracy',
                            value: '0%',
                            isDark: isDark,
                            color: const Color(0xFFF59E0B),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Bottom Action Buttons
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            AppSettings.instance.triggerHaptic();
                            onGoToQuizzes();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B5BF0),
                            elevation: 3,
                            shadowColor:
                                const Color(0xFF5B5BF0).withValues(alpha: 0.35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.play_arrow_rounded,
                                  color: Colors.white, size: 22),
                              const SizedBox(width: 8),
                              Text(
                                'Start a Quiz',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            AppSettings.instance.triggerHaptic();
                            onGoHome();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isDark
                                  ? const Color(0xFF334155)
                                  : const Color(0xFFCBD5E1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Home',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required bool isDark,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(bool isDark) {
    return Container(
      height: 32,
      width: 1,
      color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // If no quizzes completed yet, show the empty state
    if (!quiz.hasCompletedQuizzes) {
      return _buildEmptyState(context, isDark);
    }

    final total = quiz.overallTotalQuestions;
    final correct = quiz.overallCorrectAnswers;
    final wrong = quiz.overallWrongAnswers;
    final percent = quiz.overallPercentage.round();
    final completedResults = quiz.completedResults;

    final latestResult = quiz.latestResult;
    final targetCategory = latestResult != null
        ? QuizCategory.sampleCategories.firstWhere(
            (c) => c.id == latestResult.categoryId,
            orElse: () => QuizCategory.sampleCategories.first,
          )
        : QuizCategory.sampleCategories.first;

    final titleText = percent >= 70
        ? 'Great Job!'
        : (percent >= 50 ? 'Good Effort!' : 'Keep Practicing!');

    final subtitleText = completedResults.length == 1
        ? 'You completed the ${latestResult?.categoryTitle ?? 'quiz'} quiz'
        : 'You completed ${completedResults.length} quizzes';

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
                    // Top Bar with subtle Reset action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          tooltip: 'Reset Results',
                          icon: Icon(
                            Icons.refresh_rounded,
                            size: 20,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                          ),
                          onPressed: () => _confirmReset(context, quiz),
                        ),
                      ],
                    ),

                    // 1. Golden Trophy with Confetti Illustration
                    const SizedBox(
                      width: 220,
                      height: 140,
                      child: CustomPaint(
                        painter: TrophyWithConfettiPainter(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 2. Title & Subtitle (Dynamically calculated)
                    Text(
                      titleText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitleText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? const Color(0xFF94A3B8)
                            : const Color(0xFF64748B),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 3. Circular Progress Gauge (Real calculated score)
                    CircularScoreGauge(
                      correct: correct,
                      total: total,
                      percentage: percent,
                      isDark: isDark,
                    ),

                    const SizedBox(height: 24),

                    // 4. Correct Answers Card (Tap to review correct answers)
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
                              category: targetCategory,
                              initialFilter: ReviewFilter.correct,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // 5. Wrong Answers Card (Tap to review wrong answers)
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
                              category: targetCategory,
                              initialFilter: ReviewFilter.wrong,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // Review hint
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
                        final category = QuizCategory.sampleCategories.firstWhere(
                          (c) => c.id == res.categoryId,
                          orElse: () => QuizCategory.sampleCategories.first,
                        );
                        return CategoryBreakdownItem(
                          result: res,
                          isDark: isDark,
                          onTap: () {
                            AppSettings.instance.triggerHaptic();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ReviewAnswersScreen(category: category),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ],
                ),

                const SizedBox(height: 16),

                // 7. Action Buttons (Try Again / Home)
                ResultActionButtons(
                  isDark: isDark,
                  primaryLabel: 'Take Another Quiz',
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
