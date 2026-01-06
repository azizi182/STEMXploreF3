import 'package:flutter/material.dart';
import '../theme/app_color.dart';

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
            Color.fromARGB(255, 200, 243, 211),
            Color.fromARGB(255, 200, 243, 211),
          ],
        ),
      ),
      child: child,
    );
  }
}
