import 'package:flutter/material.dart';
import 'package:app/services/app_settings.dart';
import 'package:app/widgets/profile/edit_name_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
        final appBarBg = isDark ? const Color(0xFF1E293B) : Colors.white;
        final textColor = isDark ? Colors.white : const Color(0xFF1E293B);
        final borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
        final primaryColor = settings.primaryColor;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: appBarBg,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: textColor,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              settings.languageCode == 'ar' ? 'الإعدادات' : 'Settings',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: borderColor,
                height: 1,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Themes & Appearance
                _buildSectionHeader(
                  settings.languageCode == 'ar' ? 'المظهر والثيمات' : 'Theme & Appearance',
                  Icons.palette_outlined,
                  primaryColor,
                ),
                const SizedBox(height: 12),
                _buildCard(
                  isDark: isDark,
                  children: [
                    // Theme Mode Selector (Light, Dark, System)
                    Row(
                      children: [
                        _buildThemeOption(
                          title: settings.languageCode == 'ar' ? 'فاتح' : 'Light',
                          icon: Icons.light_mode_rounded,
                          isSelected: settings.themeMode == AppThemeMode.light,
                          primaryColor: primaryColor,
                          isDark: isDark,
                          onTap: () {
                            settings.setThemeMode(AppThemeMode.light);
                            _showSnackbar(context, 'Switched to Light mode');
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildThemeOption(
                          title: settings.languageCode == 'ar' ? 'داكن' : 'Dark',
                          icon: Icons.dark_mode_rounded,
                          isSelected: settings.themeMode == AppThemeMode.dark,
                          primaryColor: primaryColor,
                          isDark: isDark,
                          onTap: () {
                            settings.setThemeMode(AppThemeMode.dark);
                            _showSnackbar(context, 'Switched to Dark mode');
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildThemeOption(
                          title: settings.languageCode == 'ar' ? 'تلقائي' : 'System',
                          icon: Icons.brightness_auto_rounded,
                          isSelected: settings.themeMode == AppThemeMode.system,
                          primaryColor: primaryColor,
                          isDark: isDark,
                          onTap: () {
                            settings.setThemeMode(AppThemeMode.system);
                            _showSnackbar(context, 'Theme set to match device');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDivider(isDark),
                    const SizedBox(height: 16),

                    // Accent Color Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          settings.languageCode == 'ar' ? 'لون السمة المميز' : 'Accent Color',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
                          ),
                        ),
                        Text(
                          settings.activeAccent.name,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(AppSettings.accentColorOptions.length, (index) {
                        final option = AppSettings.accentColorOptions[index];
                        final isSelected = settings.selectedColorIndex == index;
                        return InkWell(
                          onTap: () {
                            settings.setAccentColorIndex(index);
                            _showSnackbar(context, 'Accent color set to ${option.name}');
                          },
                          borderRadius: BorderRadius.circular(22),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: option.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.white : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: option.primary.withValues(alpha: 0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                              ],
                            ),
                            child: isSelected
                                ? const Icon(Icons.check, color: Colors.white, size: 22)
                                : null,
                          ),
                        );
                      }),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Section 2: Account
                _buildSectionHeader(
                  settings.languageCode == 'ar' ? 'الحساب' : 'Account',
                  Icons.person_outline_rounded,
                  primaryColor,
                ),
                const SizedBox(height: 12),
                _buildCard(
                  isDark: isDark,
                  children: [
                    _buildActionTile(
                      icon: Icons.edit_outlined,
                      iconColor: primaryColor,
                      title: settings.languageCode == 'ar' ? 'اسم المستخدم' : 'Edit Username',
                      subtitle: settings.userName,
                      isDark: isDark,
                      onTap: () {
                        EditNameDialog.show(
                          context,
                          currentName: settings.userName,
                          onSave: (newName) {
                            settings.setUserName(newName);
                            _showSnackbar(context, 'Username updated to "$newName"');
                          },
                        );
                      },
                    ),
                    _buildDivider(isDark),
                    _buildActionTile(
                      icon: Icons.language_rounded,
                      iconColor: primaryColor,
                      title: settings.languageCode == 'ar' ? 'اللغة' : 'Language',
                      subtitle: settings.languageName,
                      isDark: isDark,
                      onTap: () => _showLanguagePicker(context, settings, isDark),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Section 3: Preferences
                _buildSectionHeader(
                  settings.languageCode == 'ar' ? 'التفضيلات' : 'Preferences',
                  Icons.tune_rounded,
                  primaryColor,
                ),
                const SizedBox(height: 12),
                _buildCard(
                  isDark: isDark,
                  children: [
                    _buildSwitchTile(
                      icon: Icons.notifications_none_rounded,
                      title: settings.languageCode == 'ar' ? 'الإشعارات' : 'Push Notifications',
                      subtitle: settings.languageCode == 'ar'
                          ? 'تنبيهات وتحديات الكويز اليومية'
                          : 'Daily quiz reminders & challenges',
                      value: settings.notificationsEnabled,
                      primaryColor: primaryColor,
                      isDark: isDark,
                      onChanged: (val) {
                        settings.setNotificationsEnabled(val);
                        _showSnackbar(
                          context,
                          val ? 'Notifications turned on' : 'Notifications turned off',
                        );
                      },
                    ),
                    _buildDivider(isDark),
                    _buildSwitchTile(
                      icon: Icons.volume_up_outlined,
                      title: settings.languageCode == 'ar' ? 'المؤثرات الصوتية' : 'Sound Effects',
                      subtitle: settings.languageCode == 'ar'
                          ? 'أصوات الإجابات الصحيحة والخاطئة'
                          : 'Audio cues for answers & scores',
                      value: settings.soundEffectsEnabled,
                      primaryColor: primaryColor,
                      isDark: isDark,
                      onChanged: (val) {
                        settings.setSoundEffectsEnabled(val);
                        _showSnackbar(
                          context,
                          val ? 'Sound effects enabled' : 'Sound effects muted',
                        );
                      },
                    ),
                    _buildDivider(isDark),
                    _buildSwitchTile(
                      icon: Icons.vibration_rounded,
                      title: settings.languageCode == 'ar' ? 'الاهتزاز التفاعلي' : 'Haptic Feedback',
                      subtitle: settings.languageCode == 'ar'
                          ? 'اهتزاز عند الضغط والتفاعل'
                          : 'Vibrate on taps and quiz answers',
                      value: settings.hapticFeedbackEnabled,
                      primaryColor: primaryColor,
                      isDark: isDark,
                      onChanged: (val) {
                        settings.setHapticFeedbackEnabled(val);
                        _showSnackbar(
                          context,
                          val ? 'Haptic feedback enabled' : 'Haptic feedback disabled',
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Section 4: About
                _buildSectionHeader(
                  settings.languageCode == 'ar' ? 'حول التطبيق' : 'About',
                  Icons.info_outline_rounded,
                  primaryColor,
                ),
                const SizedBox(height: 12),
                _buildCard(
                  isDark: isDark,
                  children: [
                    _buildActionTile(
                      icon: Icons.shield_outlined,
                      iconColor: const Color(0xFF64748B),
                      title: settings.languageCode == 'ar' ? 'سياسة الخصوصية' : 'Privacy Policy',
                      isDark: isDark,
                      onTap: () => _showPrivacyPolicy(context, isDark, primaryColor),
                    ),
                    _buildDivider(isDark),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            settings.languageCode == 'ar' ? 'إصدار التطبيق' : 'App Version',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : const Color(0xFF1E293B),
                            ),
                          ),
                          const Text(
                            'v1.0.0 (Production)',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, AppSettings settings, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language / اختر اللغة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: const Text('English (US)'),
                trailing: settings.languageCode == 'en'
                    ? Icon(Icons.check_circle_rounded, color: settings.primaryColor)
                    : null,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                tileColor: settings.languageCode == 'en'
                    ? settings.primaryColor.withValues(alpha: 0.1)
                    : null,
                onTap: () {
                  settings.setLanguageCode('en');
                  Navigator.pop(ctx);
                  _showSnackbar(context, 'Language changed to English');
                },
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Text('🇪🇬', style: TextStyle(fontSize: 24)),
                title: const Text('العربية (Arabic)'),
                trailing: settings.languageCode == 'ar'
                    ? Icon(Icons.check_circle_rounded, color: settings.primaryColor)
                    : null,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                tileColor: settings.languageCode == 'ar'
                    ? settings.primaryColor.withValues(alpha: 0.1)
                    : null,
                onTap: () {
                  settings.setLanguageCode('ar');
                  Navigator.pop(ctx);
                  _showSnackbar(context, 'تم تغيير اللغة إلى العربية');
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showPrivacyPolicy(BuildContext context, bool isDark, Color primaryColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final textColor = isDark ? Colors.white : const Color(0xFF1E293B);
        final bodyColor = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: Icon(Icons.close_rounded, color: bodyColor),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'We respect your privacy. All your quiz history, custom themes, and personal profile information are stored safely. We do not sell or share any user data with third parties.',
                style: TextStyle(fontSize: 14, height: 1.5, color: bodyColor),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Understood', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF64748B),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required bool isDark, required List<Widget> children}) {
    final cardBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderColor = isDark ? const Color(0xFF334155) : const Color(0xCCE2E8F0);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(children: children),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required IconData icon,
    required bool isSelected,
    required Color primaryColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    final unselectedBg = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final unselectedBorder = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withValues(alpha: 0.15) : unselectedBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? primaryColor : unselectedBorder,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? primaryColor : const Color(0xFF64748B),
                size: 24,
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? primaryColor : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Color primaryColor,
    required bool isDark,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
              size: 20,
            ),
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
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
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
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
