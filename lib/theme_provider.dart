import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Primary green colors
  static const Color primaryGreen = Color.fromARGB(255, 52, 137, 55);
  static const Color lightGreenBackground = Color.fromRGBO(232, 255, 215, 1);
  static const Color darkSurface = Color(0xFF2E2E2E);

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      primary: primaryGreen,
    ),
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: primaryGreen,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: Colors.white),
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
      primary: primaryGreen,
      surface: darkSurface,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkSurface,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      iconTheme: WidgetStateProperty.all(
        const IconThemeData(color: Colors.white),
      ),
    ),
  );
}

/// Optional: Gradient container that respects current theme
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.57, 1.0],
          colors: isDark
              ? [const Color.fromARGB(137, 38, 100, 2), Colors.black87]
              : [Color.fromARGB(255, 152, 206, 165), Colors.white],
        ),
      ),
      child: child,
    );
  }
}
