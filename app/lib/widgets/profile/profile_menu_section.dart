import 'package:flutter/material.dart';
import 'package:app/services/app_settings.dart';
import 'package:app/widgets/profile/profile_menu_item.dart';

class ProfileMenuSection extends StatelessWidget {
  final Color? primaryColor;
  final VoidCallback? onThemeTap;
  final VoidCallback? onMyResultsTap;
  final VoidCallback? onHelpTap;
  final VoidCallback? onLogoutTap;

  const ProfileMenuSection({
    super.key,
    this.primaryColor,
    this.onThemeTap,
    this.onMyResultsTap,
    this.onHelpTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppSettings.instance.isDarkMode(context);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderColor = isDark ? const Color(0xFF334155) : const Color(0xCCE2E8F0);
    final accent = primaryColor ?? const Color(0xFF6366F1);
    final iconBg = accent.withValues(alpha: isDark ? 0.2 : 0.1);

    final themeIconBg = isDark ? const Color(0xFF312E81) : const Color(0xFFFEF3C7);
    final themeIconColor = isDark ? const Color(0xFFA5B4FC) : const Color(0xFFD97706);

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? const Color(0x33000000) : const Color(0x080F172A),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Theme Option (Light / Dark)
          ProfileMenuItem(
            icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            iconBgColor: themeIconBg,
            iconColor: themeIconColor,
            title: 'Theme',
            subtitle: isDark ? 'Dark Mode' : 'Light Mode',
            trailing: Switch.adaptive(
              value: isDark,
              activeThumbColor: accent,
              onChanged: (value) {
                AppSettings.instance.setThemeMode(
                  value ? AppThemeMode.dark : AppThemeMode.light,
                );
              },
            ),
            onTap: onThemeTap ??
                () {
                  AppSettings.instance.setThemeMode(
                    isDark ? AppThemeMode.light : AppThemeMode.dark,
                  );
                },
          ),
          _buildDivider(isDark),
          ProfileMenuItem(
            icon: Icons.assignment_outlined,
            iconBgColor: iconBg,
            iconColor: accent,
            title: 'My Results',
            onTap: onMyResultsTap ?? () {},
          ),
          _buildDivider(isDark),
          ProfileMenuItem(
            icon: Icons.help_outline_rounded,
            iconBgColor: iconBg,
            iconColor: accent,
            title: 'Help & Support',
            onTap: onHelpTap ?? () {},
          ),
          _buildDivider(isDark),
          ProfileMenuItem(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0xFFFEE2E2),
            iconColor: const Color(0xFFEF4444),
            title: 'Log Out',
            titleColor: const Color(0xFFEF4444),
            onTap: onLogoutTap ?? () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
      indent: 16,
      endIndent: 16,
    );
  }
}
