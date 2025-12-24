import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to Language Selection instead of Login
        Navigator.of(context).pushReplacementNamed('/language');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C),
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Replaced Image with stylized text
              const Text(
                'CeLoE',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sans-serif', // Using standard font
                  fontSize: 72, // Large size
                  fontWeight: FontWeight.w300, // Thin/Light weight to mimic logo look
                  letterSpacing: -2.0, // Tighter spacing
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Learning Management System',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'sans-serif',
                  fontSize: 14, // Smaller text
                  fontWeight: FontWeight.w400, 
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}