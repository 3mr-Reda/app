import 'package:flutter/foundation.dart';
import '../models/question.dart';
import '../data/quiz_questions.dart';

class QuizProvider with ChangeNotifier {
  // 1. المتغيرات الخاصة بحالة الكويز
  int _currentQuestionIndex = 0;
  int _score = 0;
  Map<int, int> _selectedAnswers =
      {}; // تخزين رقم السؤال والإجابة التي اختارها المستخدم

  // 2. Getters عشان الشاشات تعرف تقرأ البيانات
  List<Question> get questions => sampleQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  Question get currentQuestion => sampleQuestions[_currentQuestionIndex];
  bool get isLastQuestion =>
      _currentQuestionIndex == sampleQuestions.length - 1;
  Map<int, int> get selectedAnswers => _selectedAnswers;

  // 3. اختيار إجابة للسؤال الحالي
  void selectAnswer(int answerIndex) {
    _selectedAnswers[_currentQuestionIndex] = answerIndex;
    notifyListeners(); // إعلام الشاشات لتحديث الواجهة
  }

  // 4. الانتقال للسؤال التالي وحساب الدرجة
  void nextQuestion() {
    if (_selectedAnswers.containsKey(_currentQuestionIndex)) {
      // التأكد لو الإجابة صحيحة وزيادة السكور
      if (_selectedAnswers[_currentQuestionIndex] ==
          currentQuestion.correctAnswerIndex) {
        _score++;
      }
    }

    if (!isLastQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  // 5. إعادة بدء الكويز من جديد
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswers.clear();
    notifyListeners();
  }
}
