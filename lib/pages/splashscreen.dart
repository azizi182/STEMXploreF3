import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:stemxplore/pages/mainpage.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    /// Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    /// Scale (pulse) animation
    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Mainpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              /// TAP + ANIMATION
              GestureDetector(
                onTap: _goNextPage,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset('assets/images/logoicon4.png', width: 400),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Discover your future in Science, Technology,\nEngineering & Mathematics',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              /// Hint text
            ],
          ),
        ),
      ),
    );
  }
}
