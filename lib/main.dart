import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:stemxplore/l10n/languages.dart';
import 'package:stemxplore/pages/splashscreen.dart';
import 'package:stemxplore/theme_provider.dart'; // your theme provider file
import 'package:stemxplore/bookmarkmanager.dart'; // import BookmarkManager
import 'package:stemxplore/database/insert_data.dart';
import 'package:stemxplore/database/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.getDB();
  await InsertData.insertAll();

  final db = await DBHelper.getDB();

  print(await db.query('stem_quiz'));
  print(await db.query('stem_quiz_question'));

  // Initialize localization
  final FlutterLocalization localization = FlutterLocalization.instance;
  await localization.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => BookmarkManager(),
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
