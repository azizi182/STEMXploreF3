import 'package:flutter_localization/flutter_localization.dart';
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
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    final String title = isEnglish ? 'Info' : 'Maklumat';

    final String description = isEnglish
        ? 'STEMXplore F3 is a mobile learning application designed for Form 3 secondary school students to explore Science, Technology, Engineering, and Mathematics (STEM) in a more advanced and career-oriented way. The app provides interactive content, videos, quizzes, and hands-on learning activities to help students understand STEM concepts, apply them in real life, and start thinking about future career paths.'
        : ' STEMXplore F3 ialah aplikasi pembelajaran mudah alih yang direka untuk pelajar sekolah menengah Tingkatan 3 bagi meneroka Sains, Teknologi, Kejuruteraan dan Matematik (STEM) dengan cara yang lebih maju dan berorientasikan kerjaya. Aplikasi ini menyediakan kandungan interaktif, video, kuiz dan aktiviti pembelajaran secara langsung untuk membantu pelajar memahami konsep STEM, mengaplikasikannya dalam kehidupan sebenar dan mula memikirkan laluan kerjaya masa depan.';

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildCustomAppBar(title, isEnglish, localization),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // Main Illustration Logo
                      Image.asset(
                        'assets/images/logoicon4.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      // Justified Description
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 15.5,
                          height: 1.5,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Footer Logos (Kedah and UUM)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Logo_Kedah.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit
                                .contain, // Ensures the logo doesn't stretch
                          ),
                          const SizedBox(width: 30),
                          Image.asset(
                            'assets/images/Logo_UUM.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(
    String title,
    bool isEnglish,
    FlutterLocalization localization,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 52, 137, 55), // background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 50),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () async {
              final localization = FlutterLocalization.instance;

              // Toggle language
              final currentLang =
                  localization.currentLocale?.languageCode ?? 'en';
              final newLang = currentLang == 'en' ? 'ms' : 'en';

              localization.translate(newLang);

              setState(() {}); // rebuild UI
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  key: ValueKey<bool>(isEnglish),
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
      ),
    );
  }
}
