import 'package:flutter/material.dart';
import 'package:stemxplore/pages/splashscreen.dart';
import 'package:stemxplore/theme/app_color.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.greenLight),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.greenLight,
          foregroundColor: Colors.black,
        ),
        cardTheme: const CardThemeData(
          color: Color.fromRGBO(232, 255, 215, 1),
          elevation: 4,
        ),
      ),

      home: Splashpage(),
    );
  }
}
