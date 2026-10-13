import 'package:flutter/material.dart';
import 'package:app/services/app_settings.dart';
import 'package:app/widgets/profile/profile_header.dart';
import 'package:app/widgets/profile/profile_stats_card.dart';
import 'package:app/widgets/profile/profile_menu_section.dart';
import 'package:app/widgets/profile/profile_bottom_nav_bar.dart';
import 'package:app/widgets/profile/logout_dialog.dart';
import 'package:app/widgets/profile/edit_name_dialog.dart';
import 'package:app/screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3; // Profile tab is active

  void _openEditNameDialog() {
    final settings = AppSettings.instance;
    EditNameDialog.show(
      context,
      currentName: settings.userName,
      onSave: (newName) {
        settings.setUserName(newName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Username updated to "$newName"!'),
            backgroundColor: settings.primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _showMyResults() {
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
            Row(
              children: [
                Icon(Icons.emoji_events_outlined, color: AppSettings.instance.primaryColor, size: 28),
                const SizedBox(width: 12),
                Text(
                  'My Quiz Results',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListTile(
              tileColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              title: const Text('Flutter & Dart Mastery'),
              subtitle: const Text('Completed on Oct 12 • Score: 9/10'),
              trailing: const Text('90%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ),
            const SizedBox(height: 8),
            ListTile(
              tileColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              title: const Text('Mobile UI/UX Design'),
              subtitle: const Text('Completed on Oct 10 • Score: 8/10'),
              trailing: const Text('80%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
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
                    const Positioned(
                      bottom: -45,
                      left: 24,
                      right: 24,
                      child: ProfileStatsCard(
                        quizzesTaken: 12,
                        avgScore: 8,
                      ),
                    ),
                  ],
                ),

                // Spacing for overlapping stats card
                const SizedBox(height: 65),

                // Menu Section (My Results, Settings, Help & Support, Log Out)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ProfileMenuSection(
                    primaryColor: settings.primaryColor,
                    onMyResultsTap: _showMyResults,
                    onSettingsTap: _openSettings,
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
              setState(() {
                _currentIndex = index;
              });
              settings.triggerHaptic();
            },
          ),
        );
      },
    );
  }
}
