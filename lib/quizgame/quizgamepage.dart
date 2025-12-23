import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';

class Quizgamepage extends StatefulWidget {
  const Quizgamepage({super.key});

  @override
  State<Quizgamepage> createState() => _QuizgamepageState();
}

class _QuizgamepageState extends State<Quizgamepage> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('quiz game'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Quiz game content will be displayed here.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
