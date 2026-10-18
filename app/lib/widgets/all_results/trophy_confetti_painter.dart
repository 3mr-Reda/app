import 'dart:math' as math;
import 'package:flutter/material.dart';

class TrophyWithConfettiPainter extends CustomPainter {
  const TrophyWithConfettiPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.58;

    final paint = Paint()..isAntiAlias = true;

    // 1. Confetti
    paint.color = const Color(0xFF6366F1);
    canvas.drawCircle(Offset(cx - 65, size.height * 0.18), 4, paint);

    _drawTiltedPill(
      canvas,
      Offset(cx - 55, size.height * 0.28),
      width: 12,
      height: 5,
      angle: -0.7,
      color: const Color(0xFFFBBF24),
    );

    paint.color = const Color(0xFFF97316);
    canvas.drawCircle(Offset(cx - 70, size.height * 0.44), 3.5, paint);

    _drawSquare(
      canvas,
      Offset(cx - 60, size.height * 0.58),
      size: 7,
      angle: 0.5,
      color: const Color(0xFFEC4899),
    );

    _drawTiltedPill(
      canvas,
      Offset(cx + 62, size.height * 0.22),
      width: 12,
      height: 4.5,
      angle: 0.6,
      color: const Color(0xFF14B8A6),
    );

    paint.color = const Color(0xFF8B5CF6);
    canvas.drawCircle(Offset(cx + 70, size.height * 0.32), 4.5, paint);

    paint.color = const Color(0xFFFBBF24);
    canvas.drawCircle(Offset(cx + 58, size.height * 0.48), 3.5, paint);

    _drawSquare(
      canvas,
      Offset(cx + 70, size.height * 0.58),
      size: 7,
      angle: 0.7,
      color: const Color(0xFFEF4444),
    );

    // 2. Golden Trophy
    const goldPrimary = Color(0xFFEAB308);
    const goldAccent = Color(0xFFFBBF24);
    const goldShadow = Color(0xFFCA8A04);

    final handlePaint = Paint()
      ..color = goldShadow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final leftHandle = Path()
      ..moveTo(cx - 16, cy - 14)
      ..cubicTo(cx - 38, cy - 18, cx - 38, cy + 8, cx - 14, cy + 6);
    canvas.drawPath(leftHandle, handlePaint);

    final rightHandle = Path()
      ..moveTo(cx + 16, cy - 14)
      ..cubicTo(cx + 38, cy - 18, cx + 38, cy + 8, cx + 14, cy + 6);
    canvas.drawPath(rightHandle, handlePaint);

    final cupPaint = Paint()..color = goldPrimary;
    final cupPath = Path()
      ..moveTo(cx - 20, cy - 22)
      ..lineTo(cx + 20, cy - 22)
      ..lineTo(cx + 18, cy + 2)
      ..quadraticBezierTo(cx + 12, cy + 14, cx, cy + 14)
      ..quadraticBezierTo(cx - 12, cy + 14, cx - 18, cy + 2)
      ..close();
    canvas.drawPath(cupPath, cupPaint);

    paint.color = goldAccent;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy - 22), width: 42, height: 6),
        const Radius.circular(3),
      ),
      paint,
    );

    paint.color = goldShadow;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(cx, cy + 18), width: 8, height: 10),
      paint,
    );

    paint.color = goldPrimary;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + 24), width: 20, height: 5),
        const Radius.circular(2),
      ),
      paint,
    );

    paint.color = goldShadow;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + 28), width: 30, height: 6),
        const Radius.circular(3),
      ),
      paint,
    );

    _drawStar(canvas, Offset(cx, cy - 4), 6.5, Colors.white);
  }

  void _drawTiltedPill(
    Canvas canvas,
    Offset center, {
    required double width,
    required double height,
    required double angle,
    required Color color,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final paint = Paint()..color = color;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: width, height: height),
      Radius.circular(height / 2),
    );
    canvas.drawRRect(rrect, paint);
    canvas.restore();
  }

  void _drawSquare(
    Canvas canvas,
    Offset center, {
    required double size,
    required double angle,
    required Color color,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    final paint = Paint()..color = color;
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: size, height: size),
      paint,
    );
    canvas.restore();
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path();
    const points = 5;
    final innerRadius = radius * 0.42;

    for (int i = 0; i < points * 2; i++) {
      final r = (i % 2 == 0) ? radius : innerRadius;
      final angle = (i * math.pi / points) - math.pi / 2;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
