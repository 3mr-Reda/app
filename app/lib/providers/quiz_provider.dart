import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../data/quiz_questions.dart';

class CategoryQuizResult {
  final String categoryId;
  final String categoryTitle;
  final int correct;
  final int total;
  final DateTime completedAt;
  final Map<int, int> selectedAnswers;

  const CategoryQuizResult({
    required this.categoryId,
    required this.categoryTitle,
    required this.correct,
    required this.total,
    required this.completedAt,
    required this.selectedAnswers,
  });

  int get wrong => total - correct;
  double get percentage => total == 0 ? 0 : (correct / total) * 100;
}

class QuizProvider with ChangeNotifier {
  String _categoryId = 'flutter';
  List<Question> _questions = categoryQuestions['flutter']!;
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};

  // Store completed results for all categories
  final Map<String, CategoryQuizResult> _completedResults = {
    // Initial baseline sample matching the 8/10 from the design screenshot
    'flutter': CategoryQuizResult(
      categoryId: 'flutter',
      categoryTitle: 'Flutter',
      correct: 8,
      total: 10,
      completedAt: DateTime.now().subtract(const Duration(minutes: 10)),
      selectedAnswers: {
        0: 1, // correct
        1: 0, // correct
        2: 1, // correct
        3: 1, // correct
        4: 1, // correct
        5: 2, // wrong
        6: 2, // correct
        7: 1, // correct
        8: 1, // wrong
        9: 1, // correct
      },
    ),
  };

  // Getters
  String get categoryId => _categoryId;
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
  Map<int, int> get selectedAnswers => _selectedAnswers;
  Map<String, CategoryQuizResult> get completedResults => _completedResults;

  int get totalQuestions => _questions.length;

  int get score {
    var correct = 0;
    _selectedAnswers.forEach((questionIndex, answerIndex) {
      if (questionIndex < _questions.length &&
          _questions[questionIndex].correctAnswerIndex == answerIndex) {
        correct++;
      }
    });
    return correct;
  }

  int get correctAnswers => score;
  int get wrongAnswers => _selectedAnswers.length - score;
  double get percentage =>
      totalQuestions == 0 ? 0 : (score / totalQuestions) * 100;

  bool get isCurrentAnswered =>
      _selectedAnswers.containsKey(_currentQuestionIndex);
  int? get selectedAnswerForCurrent => _selectedAnswers[_currentQuestionIndex];

  // --- Aggregate Getters across all completed quizzes ---
  int get totalQuizzesCompleted => _completedResults.length;

  int get overallTotalQuestions {
    if (_completedResults.isEmpty) return totalQuestions;
    return _completedResults.values.fold(0, (sum, res) => sum + res.total);
  }

  int get overallCorrectAnswers {
    if (_completedResults.isEmpty) return correctAnswers;
    return _completedResults.values.fold(0, (sum, res) => sum + res.correct);
  }

  int get overallWrongAnswers {
    return overallTotalQuestions - overallCorrectAnswers;
  }

  double get overallPercentage {
    if (overallTotalQuestions == 0) return 0;
    return (overallCorrectAnswers / overallTotalQuestions) * 100;
  }

  /// Save completed result for a category
  void saveCategoryResult({
    required String categoryId,
    required String categoryTitle,
    required int correct,
    required int total,
    required Map<int, int> selectedAnswers,
  }) {
    _completedResults[categoryId] = CategoryQuizResult(
      categoryId: categoryId,
      categoryTitle: categoryTitle,
      correct: correct,
      total: total,
      completedAt: DateTime.now(),
      selectedAnswers: Map.from(selectedAnswers),
    );
    notifyListeners();
  }

  /// Set the active category and reset quiz state
  void setCategory(String categoryId) {
    _categoryId = categoryId;
    _questions = getQuestionsForCategory(categoryId);
    resetQuiz();
  }

  /// Select answer for current question
  void selectAnswer(int answerIndex) {
    if (answerIndex < 0 || answerIndex >= currentQuestion.options.length) {
      return;
    }
    _selectedAnswers[_currentQuestionIndex] = answerIndex;
    notifyListeners();
  }

  /// Move to next question
  void nextQuestion() {
    if (!isLastQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  /// Reset current quiz state
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswers.clear();
    notifyListeners();
  }
}
