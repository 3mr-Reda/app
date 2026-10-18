import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizCodeSnippet extends StatelessWidget {
  final String code;

  const QuizCodeSnippet({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2238),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: RichText(
        text: _formatSyntaxHighlightedCode(code),
      ),
    );
  }

  TextSpan _formatSyntaxHighlightedCode(String code) {
    final spans = <TextSpan>[];
    final lines = code.split('\n');

    for (int l = 0; l < lines.length; l++) {
      final line = lines[l];
      final lineSpans = <TextSpan>[];

      final regex = RegExp(
          r'(void|main|var|int|String|print|\b\d+\b|[\+\-\*\/\=]|[\{\}\(\)\;]|[\w]+|\s+)');
      final matches = regex.allMatches(line);

      for (final match in matches) {
        final text = match.group(0)!;
        Color textColor = const Color(0xFFCBD5E1);

        if (text == 'void' || text == 'int' || text == 'String' || text == 'var') {
          textColor = const Color(0xFF60A5FA);
        } else if (text == 'main') {
          textColor = const Color(0xFF38BDF8);
        } else if (text == 'print') {
          textColor = const Color(0xFFC084FC);
        } else if (RegExp(r'^\d+$').hasMatch(text)) {
          textColor = const Color(0xFFF59E0B);
        } else if (text == '+' || text == '-' || text == '*' || text == '/') {
          textColor = const Color(0xFFF87171);
        }

        lineSpans.add(
          TextSpan(
            text: text,
            style: GoogleFonts.firaCode(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
              height: 1.5,
            ),
          ),
        );
      }

      spans.addAll(lineSpans);
      if (l < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return TextSpan(children: spans);
  }
}
