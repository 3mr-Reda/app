import 'dart:math' as math;
import 'package:flutter/material.dart';

class CelebrationPainter extends CustomPainter {
  const CelebrationPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.62;

    final paint = Paint()..isAntiAlias = true;

    // 1. Confetti
    _drawStar(canvas, Offset(cx - 8, size.height * 0.12), 7, const Color(0xFFFBBF24));

    paint.color = const Color(0xFFF43F5E);
    canvas.drawCircle(Offset(cx - 65, size.height * 0.13), 4, paint);

    _drawTiltedPill(
      canvas,
      Offset(cx - 42, size.height * 0.16),
      width: 10,
      height: 4,
      angle: -0.6,
      color: const Color(0xFF6366F1),
    );

    _drawTiltedPill(
      canvas,
      Offset(cx - 72, size.height * 0.44),
      width: 12,
      height: 5,
      angle: 0.8,
      color: const Color(0xFFF43F5E),
    );

    paint.color = const Color(0xFFF97316);
    canvas.drawCircle(Offset(cx + 52, size.height * 0.14), 3.5, paint);

    _drawStar(canvas, Offset(cx + 28, size.height * 0.17), 5, const Color(0xFF818CF8));

    _drawTiltedPill(
      canvas,
      Offset(cx + 70, size.height * 0.18),
      width: 12,
      height: 4.5,
      angle: -0.4,
      color: const Color(0xFF22C55E),
    );

    paint.color = const Color(0xFF3B82F6);
    canvas.drawCircle(Offset(cx + 64, size.height * 0.42), 5, paint);

    // 2. Character Torso (Blue Shirt)
    paint.color = const Color(0xFF3B82F6);
    final torsoRRect = RRect.fromRectAndCorners(
      Rect.fromCenter(center: Offset(cx, cy + 18), width: 44, height: 48),
      topLeft: const Radius.circular(8),
      topRight: const Radius.circular(8),
    );
    canvas.drawRRect(torsoRRect, paint);

    // 3. Sleeves & Raised Hands (V-shape celebration)
    final sleevePaint = Paint()
      ..color = const Color(0xFF3B82F6)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final leftArm = Path()
      ..moveTo(cx - 18, cy + 10)
      ..lineTo(cx - 36, cy - 2)
      ..lineTo(cx - 46, cy - 18);
    canvas.drawPath(leftArm, sleevePaint);

    final rightArm = Path()
      ..moveTo(cx + 18, cy + 10)
      ..lineTo(cx + 36, cy - 2)
      ..lineTo(cx + 46, cy - 18);
    canvas.drawPath(rightArm, sleevePaint);

    paint.color = const Color(0xFFFBBF24);
    canvas.drawCircle(Offset(cx - 48, cy - 22), 7, paint);
    canvas.drawCircle(Offset(cx + 48, cy - 22), 7, paint);

    canvas.drawCircle(Offset(cx - 22, cy + 40), 2.5, paint);
    canvas.drawCircle(Offset(cx + 22, cy + 40), 2.5, paint);

    // 4. White Collar notch
    paint.color = Colors.white;
    final collarPath = Path()
      ..moveTo(cx - 6, cy - 4)
      ..lineTo(cx, cy + 2)
      ..lineTo(cx + 6, cy - 4)
      ..close();
    canvas.drawPath(collarPath, paint);

    // 5. Head
    paint.color = const Color(0xFFFED7AA);
    canvas.drawCircle(Offset(cx, cy - 14), 18, paint);

    paint.color = const Color(0xFF0F172A);
    final hairRect = Rect.fromCircle(center: Offset(cx, cy - 14), radius: 18);
    canvas.drawArc(hairRect, math.pi, math.pi, true, paint);

    final hairTuft = Path()
      ..moveTo(cx - 14, cy - 14)
      ..quadraticBezierTo(cx, cy - 10, cx + 14, cy - 14)
      ..close();
    canvas.drawPath(hairTuft, paint);

    // 6. Facial Features
    final faceStroke = Paint()
      ..color = const Color(0xFF0F172A)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx - 6, cy - 14), width: 6, height: 4),
      math.pi,
      math.pi,
      false,
      faceStroke,
    );

    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx + 6, cy - 14), width: 6, height: 4),
      math.pi,
      math.pi,
      false,
      faceStroke,
    );

    final mouthStroke = Paint()
      ..color = const Color(0xFF0F172A)
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx, cy - 9), width: 8, height: 6),
      0,
      math.pi,
      false,
      mouthStroke,
    );

    final cheekPaint = Paint()
      ..color = const Color(0xFFF43F5E).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx - 10, cy - 10), 2.5, cheekPaint);
    canvas.drawCircle(Offset(cx + 10, cy - 10), 2.5, cheekPaint);
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

  void _drawStar(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path();
    const points = 5;
    final innerRadius = radius * 0.45;

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
