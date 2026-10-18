import 'package:flutter/material.dart';
import '../models/quiz_category.dart';
import '../services/app_settings.dart';
import '../widgets/quiz_details/category_about_section.dart';
import '../widgets/quiz_details/category_hero_card.dart';
import '../widgets/quiz_details/category_instructions_section.dart';
import '../widgets/quiz_details/start_quiz_button.dart';
import 'quiz_screen.dart';

class QuizDetailsScreen extends StatelessWidget {
  final QuizCategory category;

  const QuizDetailsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar with back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    size: 24,
                  ),
                  onPressed: () {
                    AppSettings.instance.triggerHaptic();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),

            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryHeroCard(category: category),
                    const SizedBox(height: 28),
                    CategoryAboutSection(aboutText: category.about),
                    const SizedBox(height: 24),
                    CategoryInstructionsSection(
                      instructions: category.instructions,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Start Quiz Button at Bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: StartQuizButton(
                onPressed: () {
                  AppSettings.instance.triggerHaptic();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(category: category),
                    ),
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
