import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../data/quiz_questions.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../services/app_settings.dart';
import '../widgets/review/review_empty_state.dart';
import '../widgets/review/review_filter_tabs.dart';
import '../widgets/review/review_question_card.dart';

export '../widgets/review/review_filter_tabs.dart' show ReviewFilter;

class ReviewAnswersScreen extends StatefulWidget {
  final QuizCategory category;
  final ReviewFilter initialFilter;

  const ReviewAnswersScreen({
    super.key,
    required this.category,
    this.initialFilter = ReviewFilter.all,
  });

  @override
  State<ReviewAnswersScreen> createState() => _ReviewAnswersScreenState();
}

class _ReviewAnswersScreenState extends State<ReviewAnswersScreen> {
  late ReviewFilter _currentFilter;

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final savedResult = quiz.completedResults[widget.category.id];
    final allQuestions = getQuestionsForCategory(widget.category.id);
    final selectedAnswers = savedResult?.selectedAnswers ??
        (quiz.categoryId == widget.category.id
            ? quiz.selectedAnswers
            : const <int, int>{});

    // Calculate counts for this specific category
    int correctCount = 0;
    int wrongCount = 0;
    for (int i = 0; i < allQuestions.length; i++) {
      if (selectedAnswers.containsKey(i)) {
        if (selectedAnswers[i] == allQuestions[i].correctAnswerIndex) {
          correctCount++;
        } else {
          wrongCount++;
        }
      }
    }

    // Filter questions based on selection
    final List<int> displayIndices = [];
    for (int i = 0; i < allQuestions.length; i++) {
      final userAns = selectedAnswers[i];
      final correctAns = allQuestions[i].correctAnswerIndex;
      final isCorrect = userAns != null && userAns == correctAns;

      if (_currentFilter == ReviewFilter.all) {
        displayIndices.add(i);
      } else if (_currentFilter == ReviewFilter.wrong && !isCorrect) {
        displayIndices.add(i);
      } else if (_currentFilter == ReviewFilter.correct && isCorrect) {
        displayIndices.add(i);
      }
    }

    final totalCount = allQuestions.length;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
          onPressed: () {
            AppSettings.instance.triggerHaptic();
            Navigator.pop(context);
          },
        ),
        title: Text(
          _currentFilter == ReviewFilter.wrong
              ? 'Wrong Questions'
              : (_currentFilter == ReviewFilter.correct
                  ? 'Correct Questions'
                  : 'Review Answers'),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Filter Selector Tabs
            ReviewFilterTabs(
              currentFilter: _currentFilter,
              totalCount: totalCount,
              wrongCount: wrongCount,
              correctCount: correctCount,
              isDark: isDark,
              onFilterChanged: (filter) {
                AppSettings.instance.triggerHaptic();
                setState(() => _currentFilter = filter);
              },
            ),

            const SizedBox(height: 8),

            // Questions List or Empty State
            Expanded(
              child: displayIndices.isEmpty
                  ? ReviewEmptyState(
                      currentFilter: _currentFilter,
                      isDark: isDark,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      itemCount: displayIndices.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, idx) {
                        final questionIndex = displayIndices[idx];
                        final question = allQuestions[questionIndex];
                        final selectedIndex = selectedAnswers[questionIndex];

                        return ReviewQuestionCard(
                          question: question,
                          questionNumber: questionIndex + 1,
                          totalCount: totalCount,
                          selectedIndex: selectedIndex,
                          isDark: isDark,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
