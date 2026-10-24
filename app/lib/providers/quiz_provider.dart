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
  final String difficulty;

  const CategoryQuizResult({
    required this.categoryId,
    required this.categoryTitle,
    required this.correct,
    required this.total,
    required this.completedAt,
    required this.selectedAnswers,
    this.difficulty = 'Medium',
  });

  int get wrong => total - correct;
  double get percentage => total == 0 ? 0 : (correct / total) * 100;
}

class QuizProvider with ChangeNotifier {
  String _categoryId = 'flutter';
  List<Question> _questions = categoryQuestions['flutter']!;
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {};

  // Store completed results for all categories (starts empty until user completes quizzes)
  final Map<String, CategoryQuizResult> _completedResults = {};

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
  bool get hasCompletedQuizzes => _completedResults.isNotEmpty;
  int get totalQuizzesCompleted => _completedResults.length;

  int get overallTotalQuestions {
    if (_completedResults.isEmpty) return 0;
    return _completedResults.values.fold(0, (sum, res) => sum + res.total);
  }

  int get overallCorrectAnswers {
    if (_completedResults.isEmpty) return 0;
    return _completedResults.values.fold(0, (sum, res) => sum + res.correct);
  }

  int get overallWrongAnswers {
    if (_completedResults.isEmpty) return 0;
    return overallTotalQuestions - overallCorrectAnswers;
  }

  double get overallPercentage {
    if (overallTotalQuestions == 0) return 0;
    return (overallCorrectAnswers / overallTotalQuestions) * 100;
  }

  double get averageScore {
    if (_completedResults.isEmpty) return 0;
    final total =
        _completedResults.values.fold(0, (sum, res) => sum + res.correct);
    return double.parse((total / _completedResults.length).toStringAsFixed(1));
  }

  CategoryQuizResult? get latestResult {
    if (_completedResults.isEmpty) return null;
    return _completedResults.values.reduce(
      (a, b) => a.completedAt.isAfter(b.completedAt) ? a : b,
    );
  }

  /// Clear all completed results back to empty state
  void clearAllResults() {
    _completedResults.clear();
    resetQuiz();
    notifyListeners();
  }

  /// Save completed result for a category
  void saveCategoryResult({
    required String categoryId,
    required String categoryTitle,
    required int correct,
    required int total,
    required Map<int, int> selectedAnswers,
    String difficulty = 'Medium',
  }) {
    _completedResults[categoryId] = CategoryQuizResult(
      categoryId: categoryId,
      categoryTitle: categoryTitle,
      correct: correct,
      total: total,
      completedAt: DateTime.now(),
      selectedAnswers: Map.from(selectedAnswers),
      difficulty: difficulty,
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
