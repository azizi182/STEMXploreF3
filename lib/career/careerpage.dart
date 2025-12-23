import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';

class Careerpage extends StatefulWidget {
  const Careerpage({super.key});

  @override
  State<Careerpage> createState() => _CareerpageState();
}

class _CareerpageState extends State<Careerpage> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Career Information'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Career information content will be displayed here.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
