import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quiz_category.dart';
import '../services/app_settings.dart';

class QuizzesScreen extends StatefulWidget {
  final void Function(QuizCategory category, String difficulty) onCategoryTap;

  const QuizzesScreen({
    super.key,
    required this.onCategoryTap,
  });

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  String _selectedDifficulty = 'Medium';

  Color get _difficultyColor {
    switch (_selectedDifficulty) {
      case 'Easy':
        return const Color(0xFF10B981);
      case 'Hard':
        return const Color(0xFFEF4444);
      case 'Medium':
      default:
        return const Color(0xFFF59E0B);
    }
  }

  void _setDifficulty(String difficulty) {
    AppSettings.instance.triggerHaptic();
    setState(() {
      _selectedDifficulty = difficulty;
    });
  }

  Widget _buildCategoryIcon(QuizCategory category) {
    if (category.isFlutter) {
      return ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        child: const FlutterLogo(size: 26),
      );
    }
    return Icon(
      category.icon ?? Icons.quiz_outlined,
      color: Colors.white,
      size: 24,
    );
  }

  Widget _buildDifficultyTab({
    required String label,
    required IconData icon,
    required Color color,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : (isDark ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? color
                : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.15)
                        : const Color(0xFF0F172A).withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 17,
                    color: isSelected
                        ? Colors.white
                        : (isDark ? color : color),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : (isDark
                              ? Colors.white
                              : const Color(0xFF1E293B)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final categories = QuizCategory.sampleCategories;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // 1. Header Title: "Choose a Category"
          Text(
            'Choose a Category',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),

          // 2. Subtitle: "Select a subject and start your quiz"
          Text(
            'Select a subject and start your quiz',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 18),

          // 3. Difficulty Selector Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Difficulty Level',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? const Color(0xFFCBD5E1)
                          : const Color(0xFF334155),
                    ),
                  ),
                  Text(
                    'Select to customize quiz',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? const Color(0xFF64748B)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _buildDifficultyTab(
                    label: 'Easy',
                    icon: Icons.sentiment_satisfied_alt_rounded,
                    color: const Color(0xFF10B981),
                    isSelected: _selectedDifficulty == 'Easy',
                    isDark: isDark,
                    onTap: () => _setDifficulty('Easy'),
                  ),
                  const SizedBox(width: 10),
                  _buildDifficultyTab(
                    label: 'Medium',
                    icon: Icons.bolt_rounded,
                    color: const Color(0xFFF59E0B),
                    isSelected: _selectedDifficulty == 'Medium',
                    isDark: isDark,
                    onTap: () => _setDifficulty('Medium'),
                  ),
                  const SizedBox(width: 10),
                  _buildDifficultyTab(
                    label: 'Hard',
                    icon: Icons.local_fire_department_rounded,
                    color: const Color(0xFFEF4444),
                    isSelected: _selectedDifficulty == 'Hard',
                    isDark: isDark,
                    onTap: () => _setDifficulty('Hard'),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 22),

          // 4. Category Cards List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategoryCard(context, category, isDark);
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    QuizCategory category,
    bool isDark,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            AppSettings.instance.triggerHaptic();
            widget.onCategoryTap(category, _selectedDifficulty);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Left Icon Box
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: category.color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: _buildCategoryIcon(category),
                ),
                const SizedBox(width: 14),

                // Center Title & Question Count + Difficulty Tag
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        category.displayTitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '${category.questionCount} questions',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '•',
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFF64748B)
                                  : const Color(0xFFCBD5E1),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: _difficultyColor
                                  .withValues(alpha: isDark ? 0.2 : 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _selectedDifficulty,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: _difficultyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right Arrow Chevron
                Icon(
                  Icons.chevron_right_rounded,
                  color: isDark
                      ? const Color(0xFF64748B)
                      : const Color(0xFFCBD5E1),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
