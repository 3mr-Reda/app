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
import 'package:app/services/app_settings.dart';
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

  testWidgets(
      'Tapping Results in bottom nav bar displays empty state initially and results after exam',
      (WidgetTester tester) async {
    final quizProvider = QuizProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: quizProvider),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Initially tap on Results tab: should display empty state
    await tester.tap(find.text('Results'));
    await tester.pumpAndSettle();

    expect(find.text('No Quiz Results Yet'), findsOneWidget);
    expect(find.text('Start a Quiz'), findsOneWidget);

    // 2. Simulate completing an exam
    quizProvider.saveCategoryResult(
      categoryId: 'flutter',
      categoryTitle: 'Flutter',
      correct: 8,
      total: 10,
      selectedAnswers: {0: 1, 1: 0},
    );
    await tester.pumpAndSettle();

    // Now it should dynamically display the calculated results
    expect(find.text('Great Job!'), findsOneWidget);
    expect(find.text('You completed the Flutter quiz'), findsOneWidget);
    expect(find.text('Correct Answers'), findsOneWidget);
    expect(find.text('Wrong Answers'), findsOneWidget);
  });

  testWidgets(
      'Tapping My Results in ProfileScreen navigates to AllResultsScreen',
      (WidgetTester tester) async {
    final quizProvider = QuizProvider();
    quizProvider.saveCategoryResult(
      categoryId: 'mathematics',
      categoryTitle: 'Mathematics',
      correct: 4,
      total: 10,
      selectedAnswers: {0: 1},
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: quizProvider),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Navigate to ProfileScreen
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('My Results'), findsOneWidget);

    // 2. Tap on "My Results" in ProfileScreen
    await tester.tap(find.text('My Results'));
    await tester.pumpAndSettle();

    // 3. Verify it navigated directly to the Results page (AllResultsScreen)
    expect(find.text('You completed the Mathematics quiz'), findsOneWidget);
    expect(find.text('4/10'), findsOneWidget);
    expect(find.text('Correct Answers'), findsOneWidget);
    expect(find.text('Wrong Answers'), findsOneWidget);
  });

  testWidgets(
      'Tapping Quizzes in bottom nav bar displays QuizzesScreen with difficulty selector',
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

    // 1. Tap on "Quizzes" in bottom nav bar
    await tester.tap(find.text('Quizzes'));
    await tester.pumpAndSettle();

    // 2. Verify "Choose a Category" header & subtitle
    expect(find.text('Choose a Category'), findsOneWidget);
    expect(find.text('Select a subject and start your quiz'), findsOneWidget);
    expect(find.text('Difficulty Level'), findsOneWidget);

    // 3. Verify difficulty selector buttons (Easy, Medium, Hard)
    expect(find.text('Easy'), findsWidgets);
    expect(find.text('Medium'), findsWidgets);
    expect(find.text('Hard'), findsWidgets);

    // 4. Tap on "Hard" difficulty selector
    await tester.tap(find.text('Hard'));
    await tester.pumpAndSettle();

    // 5. Verify category cards appear with question count
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('10 questions'), findsNWidgets(6));

    // 6. Tapping a category opens QuizDetailsScreen with Hard difficulty pill
    await tester.tap(find.text('Flutter'));
    await tester.pumpAndSettle();

    expect(find.text('Test your Flutter knowledge!'), findsOneWidget);
    expect(find.text('Hard'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
  });

  testWidgets(
      'ProfileScreen allows adding name manually and toggling theme mode',
      (WidgetTester tester) async {
    // Reset AppSettings to clean state
    AppSettings.instance.setUserName('');
    AppSettings.instance.setThemeMode(AppThemeMode.light);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => QuizProvider()),
        ],
        child: ListenableBuilder(
          listenable: AppSettings.instance,
          builder: (context, _) => MaterialApp(
            themeMode: AppSettings.instance.flutterThemeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: const HomeScreen(initialIndex: 3),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Verify default state has no hardcoded name and shows "Add Your Name"
    expect(find.text('Menna'), findsNothing);
    expect(find.text('Add Your Name'), findsOneWidget);

    // 2. Tap "Add Your Name" to open Add Name dialog
    await tester.tap(find.text('Add Your Name'));
    await tester.pumpAndSettle();

    // 3. Verify dialog has "Add Name" title and text field
    expect(find.text('Add Name'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    // 4. Enter custom name and submit
    await tester.enterText(find.byType(TextField), 'Antigravity User');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // 5. Verify the profile header now displays the new name
    expect(find.text('Antigravity User'), findsOneWidget);
    expect(find.text('Add Your Name'), findsNothing);
    expect(AppSettings.instance.userName, equals('Antigravity User'));

    // 6. Verify Theme item is visible with "Light Mode"
    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('Light Mode'), findsOneWidget);

    // 7. Toggle theme using the Switch
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    // 8. Verify AppSettings changed to dark mode and subtitle updated
    expect(AppSettings.instance.themeMode, equals(AppThemeMode.dark));
    expect(find.text('Dark Mode'), findsOneWidget);

    // 9. Tap on the Theme tile row to open the theme selection sheet
    await tester.tap(find.text('Theme'));
    await tester.pumpAndSettle();

    // 10. Verify modal bottom sheet options
    expect(find.text('Choose Theme'), findsOneWidget);
    expect(find.text('System Default'), findsOneWidget);

    // 11. Select Light Mode in modal sheet
    await tester.tap(find.text('Light Mode'));
    await tester.pumpAndSettle();

    // 12. Verify back to Light Mode
    expect(AppSettings.instance.themeMode, equals(AppThemeMode.light));
    expect(find.text('Light Mode'), findsOneWidget);
  });
}
