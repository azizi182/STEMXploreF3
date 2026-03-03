import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter/material.dart';
import 'package:stemxplore/theme_provider.dart';

class Infopage extends StatefulWidget {
  const Infopage({super.key});

  @override
  State<Infopage> createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  bool isPrivacyExpanded = false;

  final Color themeGreen = const Color.fromARGB(255, 52, 137, 55);
  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    final String description = isEnglish
        ? 'STEMXplore F3 is a mobile learning application designed for Form 3 secondary school students to explore Science, Technology, Engineering, and Mathematics (STEM) in a more advanced and career-oriented way. The app provides interactive content, videos, quizzes, and hands-on learning activities to help students understand STEM concepts, apply them in real life, and start thinking about future career paths.'
        : ' STEMXplore F3 ialah aplikasi pembelajaran mudah alih yang direka untuk pelajar sekolah menengah Tingkatan 3 bagi meneroka Sains, Teknologi, Kejuruteraan dan Matematik (STEM) dengan cara yang lebih maju dan berorientasikan kerjaya. Aplikasi ini menyediakan kandungan interaktif, video, kuiz dan aktiviti pembelajaran secara langsung untuk membantu pelajar memahami konsep STEM, mengaplikasikannya dalam kehidupan sebenar dan mula memikirkan laluan kerjaya masa depan.';

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(isEnglish),
        body: SafeArea(
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

                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: "STEM"),
                      TextSpan(text: "X", style: TextStyle(fontSize: 30)),
                      TextSpan(text: "plore "),
                      TextSpan(text: "F3", style: TextStyle(fontSize: 26)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),

                const SizedBox(height: 20),

                //what news
                buildInfoCard(
                  icon: Icons.new_releases,
                  title: isEnglish ? "What’s New" : "Apa Yang Baharu",
                  content: isEnglish
                      ? "• Added interactive STEM modules\n"
                            "• Improved bilingual support\n"
                            "• Enhanced UI design"
                      : "• Modul STEM interaktif ditambah\n"
                            "• Sokongan dwibahasa dipertingkatkan\n"
                            "• Reka bentuk UI dipertingkat",
                ),
                const SizedBox(height: 20),

                // our mission
                buildInfoCard(
                  icon: Icons.info_outline,
                  title: isEnglish
                      ? "About STEMXplore F3"
                      : "Tentang STEMXplore F3",
                  content: isEnglish
                      ? "STEMXplore F3 is a mobile learning platform designed "
                            "for Form 3 students to explore STEM subjects in an "
                            "interactive and career-oriented way.\n\n"
                            "Our Mission:\n"
                            "To inspire and empower students to develop critical "
                            "thinking and problem-solving skills through engaging "
                            "STEM learning experiences."
                      : "STEMXplore F3 ialah platform pembelajaran mudah alih "
                            "untuk pelajar Tingkatan 3 meneroka subjek STEM secara "
                            "interaktif dan berorientasikan kerjaya.\n\n"
                            "Misi Kami:\n"
                            "Memberi inspirasi dan memperkasa pelajar membangunkan "
                            "kemahiran berfikir secara kritis dan penyelesaian masalah.",
                ),
                const SizedBox(height: 20),

                //privacy policy
                buildExpandableCard(
                  icon: Icons.privacy_tip_outlined,
                  title: isEnglish ? "Privacy Policy" : "Dasar Privasi",
                  content: isEnglish
                      ? "STEMXplore F3 respects your privacy. "
                            "This application does not collect personal data "
                            "without consent. All information is used strictly "
                            "for educational purposes and improving user experience."
                      : "STEMXplore F3 menghormati privasi anda. "
                            "Aplikasi ini tidak mengumpul data peribadi tanpa kebenaran. "
                            "Semua maklumat digunakan hanya untuk tujuan pendidikan.",
                ),

                const SizedBox(height: 20),

                //terms of use
                buildInfoCard(
                  icon: Icons.description_outlined,
                  title: isEnglish ? "Terms of Service" : "Terma Perkhidmatan",
                  content: isEnglish
                      ? "By using STEMXplore F3, users agree to use the "
                            "application for educational purposes only. "
                            "All content is protected and may not be reproduced "
                            "without permission."
                      : "Dengan menggunakan STEMXplore F3, pengguna bersetuju "
                            "menggunakan aplikasi ini untuk tujuan pendidikan sahaja. "
                            "Semua kandungan dilindungi dan tidak boleh diterbitkan semula.",
                ),

                const SizedBox(height: 30),

                const SizedBox(height: 20),
                // Footer Logos (Kedah and UUM)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Logo_Kedah.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain, // Ensures the logo doesn't stretch
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
      ),
    );
  }

  AppBar buildCustomAppBar(bool isEnglish) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: App title with F3 badge
            Text(
              isEnglish ? "Info" : 'Maklumat',

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),

            // Right Side: Flag toggle (for display only now)
            GestureDetector(
              onTap: () {
                final FlutterLocalization localization =
                    FlutterLocalization.instance;

                final String currentLang =
                    localization.currentLocale?.languageCode ?? 'en';

                final String nextLocale = currentLang == 'en' ? 'ms' : 'en';

                localization.translate(nextLocale);

                setState(() {}); // rebuild UI
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
                    // The flag changes based on isEnglish
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
      ),
      backgroundColor: Color.fromARGB(255, 52, 137, 55),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: themeGreen, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpandableCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isPrivacyExpanded = !isPrivacyExpanded;
              });
            },
            child: Row(
              children: [
                Icon(icon, color: themeGreen, size: 28),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isPrivacyExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                content,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
            crossFadeState: isPrivacyExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}
