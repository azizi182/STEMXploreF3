import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:stemxplore/l10n/languages.dart';
import 'package:stemxplore/pages/splashscreen.dart';
import 'package:stemxplore/theme_provider.dart'; // your theme provider file
import 'package:stemxplore/bookmarkmanager.dart'; // import BookmarkManager

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize localization
  final FlutterLocalization localization = FlutterLocalization.instance;
  await localization.ensureInitialized();

  // Initialize BookmarkManager
  final BookmarkManager bookmarkManager = await BookmarkManager.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(
          value: bookmarkManager,
        ), // ⚡ provide BookmarkManager
      ],
      child: const MainApp(),
    ),
  );
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
    super.initState();
    localization.init(mapLocales: LOCALES, initLanguageCode: 'en');
    localization.onTranslatedLanguage = (_) => setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Dark mode configuration
      themeMode: themeProvider.themeMode,
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,

      // FlutterLocalization configuration
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,

      home: const Splashpage(),
    );
  }
}
