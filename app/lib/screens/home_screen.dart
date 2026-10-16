import 'package:flutter/material.dart';
import '../models/quiz_category.dart';
import '../services/app_settings.dart';
import '../widgets/home/category_grid.dart';
import '../widgets/home/home_header.dart';
import '../widgets/home/results_bottom_sheet.dart';
import '../widgets/profile/profile_bottom_nav_bar.dart';
import 'profile_screen.dart';
import 'quiz_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onCategoryTap(QuizCategory category) {
    AppSettings.instance.triggerHaptic();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizDetailsScreen(category: category),
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
      ResultsBottomSheet.show(context);
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      ).then((_) {
        if (mounted) setState(() => _currentIndex = 0);
      });
    }
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
            child: SingleChildScrollView(
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
                      );
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
            ),
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
