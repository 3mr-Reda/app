import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AppThemeMode {
  light,
  dark,
  system,
}

class AccentColorOption {
  final String name;
  final Color primary;
  final List<Color> gradient;

  const AccentColorOption({
    required this.name,
    required this.primary,
    required this.gradient,
  });
}

class AppSettings extends ChangeNotifier {
  static final AppSettings instance = AppSettings._();
  AppSettings._();

  // 1. Theme Mode
  AppThemeMode _themeMode = AppThemeMode.light;
  AppThemeMode get themeMode => _themeMode;

  ThemeMode get flutterThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  void setThemeMode(AppThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      triggerHaptic();
      notifyListeners();
    }
  }

  // 2. Accent Color
  static const List<AccentColorOption> accentColorOptions = [
    AccentColorOption(
      name: 'Indigo',
      primary: Color(0xFF4F46E5),
      gradient: [Color(0xFF3730A3), Color(0xFF4F46E5), Color(0xFF6366F1)],
    ),
    AccentColorOption(
      name: 'Violet',
      primary: Color(0xFF7C3AED),
      gradient: [Color(0xFF5B21B6), Color(0xFF7C3AED), Color(0xFF8B5CF6)],
    ),
    AccentColorOption(
      name: 'Emerald',
      primary: Color(0xFF059669),
      gradient: [Color(0xFF065F46), Color(0xFF059669), Color(0xFF10B981)],
    ),
    AccentColorOption(
      name: 'Amber',
      primary: Color(0xFFD97706),
      gradient: [Color(0xFF92400E), Color(0xFFD97706), Color(0xFFF59E0B)],
    ),
    AccentColorOption(
      name: 'Rose',
      primary: Color(0xFFE11D48),
      gradient: [Color(0xFF9F1239), Color(0xFFE11D48), Color(0xFFF43F5E)],
    ),
  ];

  int _selectedColorIndex = 0;
  int get selectedColorIndex => _selectedColorIndex;
  AccentColorOption get activeAccent => accentColorOptions[_selectedColorIndex];
  Color get primaryColor => activeAccent.primary;
  List<Color> get primaryGradient => activeAccent.gradient;

  void setAccentColorIndex(int index) {
    if (index >= 0 && index < accentColorOptions.length && _selectedColorIndex != index) {
      _selectedColorIndex = index;
      triggerHaptic();
      notifyListeners();
    }
  }

  // 3. User Info
  String _userName = 'Menna';
  String get userName => _userName;

  final String _role = 'Quiz Enthusiast';
  String get role => _role;

  void setUserName(String name) {
    if (name.trim().isNotEmpty && _userName != name) {
      _userName = name.trim();
      triggerHaptic();
      notifyListeners();
    }
  }

  // 4. Preferences
  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  void setNotificationsEnabled(bool value) {
    if (_notificationsEnabled != value) {
      _notificationsEnabled = value;
      triggerHaptic();
      notifyListeners();
    }
  }

  bool _soundEffectsEnabled = true;
  bool get soundEffectsEnabled => _soundEffectsEnabled;

  void setSoundEffectsEnabled(bool value) {
    if (_soundEffectsEnabled != value) {
      _soundEffectsEnabled = value;
      triggerHaptic();
      notifyListeners();
    }
  }

  bool _hapticFeedbackEnabled = true;
  bool get hapticFeedbackEnabled => _hapticFeedbackEnabled;

  void setHapticFeedbackEnabled(bool value) {
    if (_hapticFeedbackEnabled != value) {
      _hapticFeedbackEnabled = value;
      if (value) {
        HapticFeedback.mediumImpact();
      }
      notifyListeners();
    }
  }

  void triggerHaptic() {
    if (_hapticFeedbackEnabled) {
      HapticFeedback.lightImpact();
    }
  }

  // 5. Language
  String _languageCode = 'en'; // 'en' or 'ar'
  String get languageCode => _languageCode;
  String get languageName => _languageCode == 'ar' ? 'العربية' : 'English (US)';

  void setLanguageCode(String code) {
    if (_languageCode != code) {
      _languageCode = code;
      triggerHaptic();
      notifyListeners();
    }
  }

  // Helper check for dark mode
  bool isDarkMode(BuildContext context) {
    if (_themeMode == AppThemeMode.dark) return true;
    if (_themeMode == AppThemeMode.light) return false;
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }
}
