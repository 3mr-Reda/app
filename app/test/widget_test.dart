import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/quiz_details_screen.dart';
import 'package:app/models/quiz_category.dart';
import 'package:app/widgets/category_card.dart';
import 'package:app/screens/quiz_screen.dart';
import 'package:app/screens/result_screen.dart';
import 'package:app/providers/quiz_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('App loads SplashScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('HomeScreen displays greeting and category cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Good Morning ,'), findsOneWidget);
    expect(find.text('Ready to test your knowledge?'), findsOneWidget);
    expect(find.byType(CategoryCard), findsNWidgets(6));
  });

  testWidgets('QuizDetailsScreen displays category details and instructions',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: QuizDetailsScreen(category: QuizCategory.sampleCategories.first),
      ),
    );

    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Test your Flutter knowledge!'), findsOneWidget);
    expect(find.text('About this quiz'), findsOneWidget);
    expect(find.text('Instructions'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
  });

  testWidgets('QuizScreen displays question, timer, options and Next button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: MaterialApp(
          home: QuizScreen(category: QuizCategory.sampleCategories.first),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1/10'), findsOneWidget);
    expect(find.text('What is the main language used in Flutter development?'),
        findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('ResultScreen displays Times Up, gauge, stats cards, and action buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: MaterialApp(
          home: ResultScreen(category: QuizCategory.sampleCategories.first),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("Time's Up!"), findsOneWidget);
    expect(find.text('You answered all the questions'), findsOneWidget);
    expect(find.text('Correct'), findsOneWidget);
    expect(find.text('Wrong'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('Tapping Results in bottom nav bar displays AllResultsScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Tap on the Results tab in bottom navigation bar
    await tester.tap(find.text('Results'));
    await tester.pumpAndSettle();

    expect(find.text('Great Job!'), findsOneWidget);
    expect(find.text('You completed the quiz'), findsOneWidget);
    expect(find.text('Correct Answers'), findsOneWidget);
    expect(find.text('Wrong Answers'), findsOneWidget);
  });
}
