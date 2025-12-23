import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';

class Learningmaterialpage extends StatefulWidget {
  const Learningmaterialpage({super.key});

  @override
  State<Learningmaterialpage> createState() => _LearningmaterialpageState();
}

class _LearningmaterialpageState extends State<Learningmaterialpage> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('learning material'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Learning material content will be displayed here.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
