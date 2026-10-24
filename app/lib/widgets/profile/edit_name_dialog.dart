import 'package:flutter/material.dart';

class EditNameDialog extends StatefulWidget {
  final String currentName;
  final ValueChanged<String> onSave;

  const EditNameDialog({
    super.key,
    required this.currentName,
    required this.onSave,
  });

  static Future<void> show(
    BuildContext context, {
    required String currentName,
    required ValueChanged<String> onSave,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => EditNameDialog(
        currentName: currentName,
        onSave: onSave,
      ),
    );
  }

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isNewName = widget.currentName.trim().isEmpty;
    final bgColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final titleColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final inputFill = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
    final hintColor = isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8);

    return AlertDialog(
      backgroundColor: bgColor,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF312E81)
                  : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isNewName ? Icons.person_add_rounded : Icons.edit_rounded,
              color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF6366F1),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            isNewName ? 'Add Name' : 'Edit Name',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: titleColor,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            autofocus: true,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
            decoration: InputDecoration(
              hintText: 'Enter your name',
              hintStyle: TextStyle(color: hintColor),
              prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF6366F1)),
              filled: true,
              fillColor: inputFill,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    side: BorderSide(color: borderColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final newName = _controller.text.trim();
                    if (newName.isNotEmpty) {
                      widget.onSave(newName);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    backgroundColor: const Color(0xFF4F46E5),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    isNewName ? 'Add' : 'Save',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
