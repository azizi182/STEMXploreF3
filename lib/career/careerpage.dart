import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:stemxplore/theme_provider.dart';

class Careerpage extends StatefulWidget {
  final VoidCallback onStartQuiz;
  const Careerpage({super.key, required this.onStartQuiz});

  @override
  State<Careerpage> createState() => _CareerpageState();
}

class _CareerpageState extends State<Careerpage> {
  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(isEnglish, context),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.psychology, size: 100, color: Colors.white),

              SizedBox(height: 20),

              Text(
                isEnglish
                    ? "Discover Your STEM Career 🔍"
                    : "Kenali Kerjaya STEM Anda 🔍",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              Text(
                isEnglish
                    ? "Answer a few questions to discover which STEM field suits you best: Science, Technology, Engineering, or Mathematics."
                    : "Jawab beberapa soalan untuk mengetahui bidang STEM yang paling sesuai dengan anda.",
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(179, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                icon: Icon(Icons.play_arrow),
                label: Text(
                  isEnglish ? "Start Career Quiz" : "Mula Kuiz Kerjaya",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                onPressed: () {
                  widget.onStartQuiz();
                },
              ),
            ],
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
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    // The flag changes based on isEnglish
                    isEnglish
                        ? 'assets/flag/language ms_flag.png'
                        : 'assets/flag/language us_flag.png',
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  isEnglish ? 'MS' : 'EN',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
