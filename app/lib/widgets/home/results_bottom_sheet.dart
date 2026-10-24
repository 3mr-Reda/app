import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/quiz_category.dart';
import '../../providers/quiz_provider.dart';
import '../../screens/review_answers_screen.dart';
import '../../services/app_settings.dart';

class ResultsBottomSheet {
  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quiz = context.read<QuizProvider>();
    final results = quiz.completedResults.values.toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  color: AppSettings.instance.primaryColor,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'My Quiz Results',
                  style: GoogleFonts.urbanist(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (results.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: 44,
                        color: isDark
                            ? const Color(0xFF64748B)
                            : const Color(0xFF94A3B8),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No quizzes completed yet',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color:
                              isDark ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Complete a quiz to view your score history here.',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...results.map((res) {
                final category = QuizCategory.sampleCategories.firstWhere(
                  (c) => c.id == res.categoryId,
                  orElse: () => QuizCategory.sampleCategories.first,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    tileColor: isDark
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFF8FAFC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    title: Text(res.categoryTitle),
                    subtitle: Text('Score: ${res.correct}/${res.total}'),
                    trailing: Text(
                      '${res.percentage.round()}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: res.percentage >= 70
                            ? Colors.green
                            : const Color(0xFF5B5BF0),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ReviewAnswersScreen(category: category),
                        ),
                      );
                    },
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
