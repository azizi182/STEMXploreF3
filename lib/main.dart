import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/l10n/languages.dart';
import 'package:stemxplore/pages/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FlutterLocalization localization = FlutterLocalization.instance;
  await localization.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(mapLocales: LOCALES, initLanguageCode: 'en');
    localization.onTranslatedLanguage = (_) => setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(147, 218, 151, 1),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 52, 137, 55),
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
