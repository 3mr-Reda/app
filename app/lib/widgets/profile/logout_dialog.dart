import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback? onConfirm;

  const LogoutDialog({super.key, this.onConfirm});

  static Future<void> show(BuildContext context, {VoidCallback? onConfirm}) {
    return showDialog(
      context: context,
      builder: (ctx) => LogoutDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Log Out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
          child: const Text('Log Out', style: TextStyle(color: Color(0xFFEF4444))),
        ),
      ],
    );
  }
}
