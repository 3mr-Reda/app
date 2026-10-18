import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../services/app_settings.dart';
import '../widgets/quiz/quiz_code_snippet.dart';
import '../widgets/quiz/quiz_exit_dialog.dart';
import '../widgets/quiz/quiz_option_card.dart';
import '../widgets/quiz/quiz_top_bar.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final QuizCategory category;
  final void Function(BuildContext context)? onFinish;

  const QuizScreen({
    super.key,
    required this.category,
    this.onFinish,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  int _secondsRemaining = 75; // 01:15 default countdown

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final provider = context.read<QuizProvider>();
      provider.setCategory(widget.category.id);
      _startTimer();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 75;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
        _handleTimeUp();
      }
    });
  }

  void _handleTimeUp() {
    AppSettings.instance.triggerHaptic();
    final quiz = context.read<QuizProvider>();
    _finishQuiz(quiz);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onNext(QuizProvider quiz) {
    AppSettings.instance.triggerHaptic();
    if (quiz.isLastQuestion) {
      _finishQuiz(quiz);
    } else {
      quiz.nextQuestion();
    }
  }

  void _finishQuiz(QuizProvider quiz) {
    _timer?.cancel();
    quiz.saveCategoryResult(
      categoryId: widget.category.id,
      categoryTitle: widget.category.displayTitle,
      correct: quiz.correctAnswers,
      total: quiz.totalQuestions,
      selectedAnswers: quiz.selectedAnswers,
    );

    if (widget.onFinish != null) {
      widget.onFinish!(context);
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(category: widget.category),
      ),
    );
  }

  Future<void> _confirmExit() async {
    AppSettings.instance.triggerHaptic();
    final shouldLeave = await QuizExitDialog.show(context);
    if (shouldLeave == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (quiz.questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = quiz.currentQuestion;
    final currentIndex = quiz.currentQuestionIndex;
    final totalQuestions = quiz.totalQuestions;
    final selectedOptionIndex = quiz.selectedAnswerForCurrent;
    final isAnswered = quiz.isCurrentAnswered;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _confirmExit();
        }
      },
      child: Scaffold(
        backgroundColor:
            isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Column(
            children: [
              // 1. Top Bar (Progress Counter on Left + Timer Badge on Right)
              QuizTopBar(
                currentQuestionIndex: currentIndex,
                totalQuestions: totalQuestions,
                secondsRemaining: _secondsRemaining,
                isDark: isDark,
              ),

              // 2. Question, Code snippet, and Options
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Question Title
                      Text(
                        currentQuestion.questionText,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          height: 1.35,
                          color: isDark
                              ? Colors.white
                              : const Color(0xFF0F172A),
                        ),
                      ),

                      // Optional Code Snippet Container (Like Screenshot 2)
                      if (currentQuestion.codeSnippet != null) ...[
                        const SizedBox(height: 16),
                        QuizCodeSnippet(code: currentQuestion.codeSnippet!),
                      ],

                      const SizedBox(height: 24),

                      // Options List
                      ...List.generate(currentQuestion.options.length, (index) {
                        final optionText = currentQuestion.options[index];
                        final isSelected = selectedOptionIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: QuizOptionCard(
                            isDark: isDark,
                            optionText: optionText,
                            isSelected: isSelected,
                            onTap: () {
                              AppSettings.instance.triggerHaptic();
                              quiz.selectAnswer(index);
                            },
                          ),
                        );
                      }),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // 3. Bottom Next / Finish Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: isAnswered ? () => _onNext(quiz) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B5BF0),
                      disabledBackgroundColor: isDark
                          ? const Color(0xFF334155)
                          : const Color(0xFF818CF8).withValues(alpha: 0.5),
                      elevation: isAnswered ? 4 : 0,
                      shadowColor:
                          const Color(0xFF5B5BF0).withValues(alpha: 0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quiz.isLastQuestion ? 'Finish' : 'Next',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
