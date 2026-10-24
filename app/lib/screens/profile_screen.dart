import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/providers/quiz_provider.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/services/app_settings.dart';
import 'package:app/widgets/profile/edit_name_dialog.dart';
import 'package:app/widgets/profile/logout_dialog.dart';
import 'package:app/widgets/profile/profile_bottom_nav_bar.dart';
import 'package:app/widgets/profile/profile_header.dart';
import 'package:app/widgets/profile/profile_menu_section.dart';
import 'package:app/widgets/profile/profile_stats_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // Profile tab is active

  void _openEditNameDialog() {
    final settings = AppSettings.instance;
    final hadName = settings.userName.isNotEmpty;
    EditNameDialog.show(
      context,
      currentName: settings.userName,
      onSave: (newName) {
        settings.setUserName(newName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              hadName
                  ? 'Username updated to "$newName"!'
                  : 'Welcome, $newName!',
            ),
            backgroundColor: settings.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
    );
  }

  void _showThemeDialog() {
    final settings = AppSettings.instance;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final currentMode = settings.themeMode;
            final sheetDark = Theme.of(context).brightness == Brightness.dark;
            final textColor = sheetDark ? Colors.white : const Color(0xFF1E293B);
            final subtextColor =
                sheetDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

            Widget buildThemeOption({
              required AppThemeMode mode,
              required String title,
              required String subtitle,
              required IconData icon,
              required Color iconColor,
              required Color iconBg,
            }) {
              final isSelected = currentMode == mode;
              final accent = settings.primaryColor;

              return InkWell(
                onTap: () {
                  settings.setThemeMode(mode);
                  setModalState(() {});
                  Navigator.pop(ctx);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? accent.withValues(alpha: sheetDark ? 0.2 : 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? accent
                          : (sheetDark
                              ? const Color(0xFF334155)
                              : const Color(0xFFE2E8F0)),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: iconBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: iconColor, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isSelected ? accent : textColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 12,
                                color: subtextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle_rounded,
                            color: accent, size: 22)
                      else
                        Icon(Icons.circle_outlined,
                            color: subtextColor, size: 20),
                    ],
                  ),
                ),
              );
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: sheetDark
                              ? const Color(0xFF475569)
                              : const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Choose Theme',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select your preferred appearance mode',
                      style: TextStyle(
                        fontSize: 13,
                        color: subtextColor,
                      ),
                    ),
                    const SizedBox(height: 18),
                    buildThemeOption(
                      mode: AppThemeMode.light,
                      title: 'Light Mode',
                      subtitle: 'Bright, crisp and clean interface',
                      icon: Icons.light_mode_rounded,
                      iconColor: const Color(0xFFD97706),
                      iconBg: const Color(0xFFFEF3C7),
                    ),
                    buildThemeOption(
                      mode: AppThemeMode.dark,
                      title: 'Dark Mode',
                      subtitle: 'Sleek dark look, comfortable for low light',
                      icon: Icons.dark_mode_rounded,
                      iconColor: const Color(0xFFA5B4FC),
                      iconBg: const Color(0xFF312E81),
                    ),
                    buildThemeOption(
                      mode: AppThemeMode.system,
                      title: 'System Default',
                      subtitle: 'Matches your device display settings',
                      icon: Icons.settings_suggest_rounded,
                      iconColor: const Color(0xFF0D9488),
                      iconBg: const Color(0xFFCCFBF1),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _goToResults() {
    AppSettings.instance.triggerHaptic();
    if (Navigator.canPop(context)) {
      Navigator.pop(context, 2);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(initialIndex: 2),
        ),
      );
    }
  }

  void _showHelpSupport() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Have any questions or need help with quizzes? Reach out to us at support@quizapp.com or check our FAQ.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.email_outlined, color: Colors.white),
                label: const Text('Contact Support', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppSettings.instance.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => Navigator.pop(ctx),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
        final quiz = context.watch<QuizProvider>();

        return Scaffold(
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Top Section: Gradient Header + Overlapping Stats Card
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    ProfileHeader(
                      name: settings.userName,
                      role: settings.role,
                      gradientColors: settings.primaryGradient,
                      primaryColor: settings.primaryColor,
                      onEditName: _openEditNameDialog,
                    ),
                    Positioned(
                      bottom: -45,
                      left: 24,
                      right: 24,
                      child: GestureDetector(
                        onTap: _goToResults,
                        child: ProfileStatsCard(
                          quizzesTaken: quiz.totalQuizzesCompleted,
                          avgScore: quiz.averageScore,
                        ),
                      ),
                    ),
                  ],
                ),

                // Spacing for overlapping stats card
                const SizedBox(height: 65),

                // Menu Section (My Results, Help & Support, Log Out)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ProfileMenuSection(
                    primaryColor: settings.primaryColor,
                    onThemeTap: _showThemeDialog,
                    onMyResultsTap: _goToResults,
                    onHelpTap: _showHelpSupport,
                    onLogoutTap: () {
                      LogoutDialog.show(context);
                    },
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
          bottomNavigationBar: ProfileBottomNavBar(
            currentIndex: _currentIndex,
            activeColor: settings.primaryColor,
            onTap: (index) {
              settings.triggerHaptic();
              if (index == 0) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context, 0);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HomeScreen(initialIndex: 0)),
                  );
                }
              } else if (index == 1) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context, 1);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HomeScreen(initialIndex: 1)),
                  );
                }
              } else if (index == 2) {
                _goToResults();
              } else {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
          ),
        );
      },
    );
  }
}
