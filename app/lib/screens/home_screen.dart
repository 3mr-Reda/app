import 'package:flutter/material.dart';
import '../models/quiz_category.dart';
import '../services/app_settings.dart';
import '../widgets/home/category_grid.dart';
import '../widgets/home/home_header.dart';
import '../widgets/profile/profile_bottom_nav_bar.dart';
import 'all_results_screen.dart';
import 'profile_screen.dart';
import 'quiz_details_screen.dart';
import 'quizzes_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onCategoryTap(QuizCategory category, [String difficulty = 'Medium']) {
    AppSettings.instance.triggerHaptic();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizDetailsScreen(
          category: category,
          difficulty: difficulty,
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    AppSettings.instance.triggerHaptic();
    if (index == 0) {
      setState(() => _currentIndex = 0);
    } else if (index == 1) {
      setState(() => _currentIndex = 1);
    } else if (index == 2) {
      setState(() => _currentIndex = 2);
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      ).then((selectedTab) {
        if (mounted && selectedTab is int) {
          setState(() => _currentIndex = selectedTab);
        } else if (mounted) {
          setState(() => _currentIndex = 0);
        }
      });
    }
  }

  Widget _buildBody() {
    if (_currentIndex == 1) {
      return QuizzesScreen(onCategoryTap: _onCategoryTap);
    }
    if (_currentIndex == 2) {
      return AllResultsScreen(
        onGoHome: () => setState(() => _currentIndex = 0),
        onGoToQuizzes: () => setState(() => _currentIndex = 1),
      );
    }
    if (_currentIndex == 3) {
      return const ProfileScreen();
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(
            onProfileTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              ).then((selectedTab) {
                if (mounted && selectedTab is int) {
                  setState(() => _currentIndex = selectedTab);
                }
              });
            },
          ),
          const SizedBox(height: 24),
          CategoryGrid(
            categories: QuizCategory.sampleCategories,
            onCategoryTap: _onCategoryTap,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: _buildBody(),
          ),
          bottomNavigationBar: ProfileBottomNavBar(
            currentIndex: _currentIndex,
            activeColor: settings.primaryColor,
            onTap: _onBottomNavTap,
          ),
        );
      },
    );
  }
}
