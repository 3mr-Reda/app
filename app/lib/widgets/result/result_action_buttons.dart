import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultActionButtons extends StatelessWidget {
  final bool isDark;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String secondaryLabel;
  final VoidCallback onSecondaryPressed;

  const ResultActionButtons({
    super.key,
    required this.isDark,
    this.primaryLabel = 'Try Again',
    required this.onPrimaryPressed,
    this.secondaryLabel = 'Home',
    required this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Column(
        children: [
          // Primary Button (e.g. Try Again)
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: onPrimaryPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B5BF0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                primaryLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Secondary Button (e.g. Home)
          SizedBox(
            width: double.infinity,
            height: 54,
            child: OutlinedButton(
              onPressed: onSecondaryPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    isDark ? Colors.transparent : Colors.white,
                side: BorderSide(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                secondaryLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF5B5BF0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
