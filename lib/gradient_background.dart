import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.57, 1.0],
          colors: [
            Color.fromARGB(255, 152, 206, 165),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),
      ),
      child: child,
    );
  }
}
