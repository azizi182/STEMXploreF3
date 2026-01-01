import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';

class Infopage extends StatefulWidget {
  const Infopage({super.key});

  @override
  State<Infopage> createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('info'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'info content will be displayed here.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
