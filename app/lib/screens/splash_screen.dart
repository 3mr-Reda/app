import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _moveY;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // حركة الصاروخ فوق وتحت
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _moveY = Tween<double>(begin: -12, end: 12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quizzy',
                style: Theme.of(context).textTheme.displayLarge,
              ),
               SizedBox(height: 8),
              Text(
                'Test Your Knowledge',
                style: Theme.of(context).textTheme.titleMedium,
              ),
               SizedBox(height: 80),
              AnimatedBuilder(
                animation: _moveY,
                builder: (context, child) => Transform.translate(
                  offset: Offset(0, _moveY.value),
                  child: child,
                ),
                child: Image.asset(
                  'assets/images/rocket.png',
                  width: 180,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}