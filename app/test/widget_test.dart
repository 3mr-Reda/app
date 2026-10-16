import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';
import 'package:app/screens/splash_screen.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/quiz_details_screen.dart';
import 'package:app/models/quiz_category.dart';
import 'package:app/widgets/category_card.dart';

void main() {
  testWidgets('App loads SplashScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);
  });

  testWidgets('HomeScreen displays greeting and category cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Good Morning ,'), findsOneWidget);
    expect(find.text('Ready to test your knowledge?'), findsOneWidget);
    expect(find.byType(CategoryCard), findsNWidgets(6));
  });

  testWidgets('QuizDetailsScreen displays category details and instructions', (WidgetTester tester) async {
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
}
