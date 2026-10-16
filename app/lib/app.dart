import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_colors.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
          displayLarge: GoogleFonts.urbanist(
            fontSize: 60,
            fontWeight: FontWeight.w900,
            color: AppColors.textDark,
          ),
          titleMedium: GoogleFonts.urbanist(
            fontSize: 18,
            color: AppColors.textDark,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}