import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
//import 'package:stemxplore/gradient_background.dart';
import 'package:stemxplore/theme_provider.dart';

class Careerpage extends StatefulWidget {
  const Careerpage({super.key});

  @override
  State<Careerpage> createState() => _CareerpageState();
}

class _CareerpageState extends State<Careerpage> {
  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(isEnglish, context),
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

  AppBar buildCustomAppBar(bool isEnglish, BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Text(
          isEnglish ? "Career Information" : 'Informasi Karier',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: theme.brightness == Brightness.dark
                ? Colors.black
                : Colors.black,
          ),
        ),
      ),
      backgroundColor: theme.brightness == Brightness.dark
          ? Color.fromRGBO(179, 204, 161, 1)
          : Color.fromARGB(255, 52, 137, 55),
      actions: [
        GestureDetector(
          onTap: () {
            final FlutterLocalization localization =
                FlutterLocalization.instance;
            final String currentLang =
                localization.currentLocale?.languageCode ?? 'en';
            final String nextLocale = currentLang == 'en' ? 'ms' : 'en';
            localization.translate(nextLocale);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ClipOval(
              child: Image.asset(
                isEnglish
                    ? 'assets/flag/language ms_flag.png'
                    : 'assets/flag/language us_flag.png',
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
