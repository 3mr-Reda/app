import 'package:flutter/material.dart';

class QuizCategory {
  final String id;
  final String title;
  final String subtitle;
  final String about;
  final int quizCount;
  final int questionCount;
  final int durationMinutes;
  final Color color;
  final IconData? icon;
  final bool isFlutter;
  final List<String> instructions;

  const QuizCategory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.about,
    required this.quizCount,
    this.questionCount = 10,
    this.durationMinutes = 15,
    required this.color,
    this.icon,
    this.isFlutter = false,
    this.instructions = const [
      'Choose the correct answer from 4 options.',
      "You can't change your answer after submission.",
      'Complete all questions before time runs out.',
    ],
  });

  String get displayTitle => title.replaceAll('\n', ' ');

  static const List<QuizCategory> sampleCategories = [
    QuizCategory(
      id: 'flutter',
      title: 'Flutter',
      subtitle: 'Test your Flutter knowledge!',
      about:
          'This quiz covers the basics of Flutter, including widgets, state management, and more.',
      quizCount: 10,
      questionCount: 10,
      durationMinutes: 15,
      color: Color(0xFF4C6EF5),
      isFlutter: true,
    ),
    QuizCategory(
      id: 'dart',
      title: 'Dart',
      subtitle: 'Test your Dart programming skills!',
      about:
          'This quiz covers Dart language fundamentals, null safety, OOP principles, and async programming.',
      quizCount: 10,
      questionCount: 10,
      durationMinutes: 15,
      color: Color(0xFF00BFA5),
      icon: Icons.adjust_rounded,
    ),
    QuizCategory(
      id: 'general_knowledge',
      title: 'General\nKnowledge',
      subtitle: 'Test your general knowledge!',
      about:
          'Explore a wide range of questions spanning history, geography, science, and world culture.',
      quizCount: 10,
      questionCount: 10,
      durationMinutes: 15,
      color: Color(0xFFFA8F21),
      icon: Icons.psychology_rounded,
    ),
    QuizCategory(
      id: 'mathematics',
      title: 'Mathematics',
      subtitle: 'Test your mathematics knowledge!',
      about:
          'Challenge your problem-solving skills with algebra, arithmetic, geometry, and logic puzzles.',
      quizCount: 10,
      questionCount: 10,
      durationMinutes: 15,
      color: Color(0xFFF43F5E),
      icon: Icons.menu_book_rounded,
    ),
    QuizCategory(
      id: 'english',
      title: 'English',
      subtitle: 'Test your English language skills!',
      about:
          'Test your grammar, vocabulary, idioms, and reading comprehension in modern English.',
      quizCount: 10,
      questionCount: 10,
      durationMinutes: 15,
      color: Color(0xFF6366F1),
      icon: Icons.auto_stories_rounded,
    ),
    QuizCategory(
      id: 'science',
      title: 'Science',
      subtitle: 'Test your scientific knowledge!',
      about:
          'Discover questions spanning physics, chemistry, biology, astronomy, and the natural world.',
      quizCount: 10,
      questionCount: 10,
      durationMinutes: 15,
      color: Color(0xFF10B981),
      icon: Icons.science_outlined,
    ),
  ];
}
