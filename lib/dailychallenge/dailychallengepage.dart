import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';

class Dailychallengepage extends StatefulWidget {
  const Dailychallengepage({super.key});

  @override
  State<Dailychallengepage> createState() => _DailychallengepageState();
}

class _DailychallengepageState extends State<Dailychallengepage> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Daily Challenge'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Daily challenge content will be displayed here.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
