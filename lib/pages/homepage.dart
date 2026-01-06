import 'dart:convert';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stemxplore/ipaddress.dart';

import 'package:stemxplore/stemhighlight/stem_highlight.dart';

class Homepage extends StatefulWidget {
  final Function(int) onNavigate;
  final Function(Map) onHighlightTap;

  const Homepage({
    super.key,
    required this.onNavigate,
    required this.onHighlightTap,
  });

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List highlights = [];
  int currentHighlightIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchStemHighlights();
  }

  Future<void> fetchStemHighlights() async {
    final response = await http.get(
      Uri.parse('${ipaddress.baseUrl}api/get_stem_highlight.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        highlights = json.decode(response.body);
      });
    }
  }

  String _getTranslatedText(String key, bool isEnglish) {
    final Map<String, Map<String, String>> localizedValues = {
      'stemInfo': {'en': 'STEM Info', 'ms': 'Info STEM'},
      'learning': {'en': 'Learning Material', 'ms': 'Bahan Pembelajaran'},
      'quiz': {'en': 'Quiz Game', 'ms': 'Permainan Kuiz'},
      'careers': {'en': 'STEM Careers', 'ms': 'Kerjaya STEM'},
      'challenge': {'en': 'Daily Challenge', 'ms': 'Cabaran Harian'},
      'faq': {'en': 'FAQ', 'ms': 'Soalan Lazim'},
      'highlights': {'en': 'STEM Highlights:', 'ms': 'Sorotan STEM:'},
      'readMore': {'en': 'Read more', 'ms': 'Baca lagi'},
    };
    return localizedValues[key]?[isEnglish ? 'en' : 'ms'] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          _buildTopBar(isEnglish, localization),

          ///FEATURES GRID (UNCHANGED)
          GridView.count(
            childAspectRatio: 1.15,
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 4, // vertical gap
            crossAxisSpacing: 4, // horizontal gap

            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureCard(
                label: _getTranslatedText('stemInfo', isEnglish),
                icon: Icons.science,
                imagePath: 'assets/images/infostem2.png',
                onTap: () => widget.onNavigate(4),
              ),
              FeatureCard(
                label: _getTranslatedText('learning', isEnglish),
                icon: Icons.menu_book,
                imagePath: 'assets/images/learningmaterial2.png',
                onTap: () => widget.onNavigate(5),
              ),
              FeatureCard(
                label: _getTranslatedText('quiz', isEnglish),
                icon: Icons.question_answer,
                imagePath: 'assets/images/quizicon2.png',

                onTap: () => widget.onNavigate(6),
              ),
              FeatureCard(
                label: _getTranslatedText('careers', isEnglish),
                icon: Icons.work,
                imagePath: 'assets/images/career2.png',

                onTap: () => widget.onNavigate(7),
              ),
              FeatureCard(
                label: _getTranslatedText('challenge', isEnglish),
                icon: Icons.calendar_today,
                imagePath: 'assets/images/dailychallengeicon2.png',

                onTap: () => widget.onNavigate(8),
              ),
              FeatureCard(
                label: _getTranslatedText('faq', isEnglish),
                icon: Icons.help_center_outlined,
                imagePath: 'assets/images/faqicon2.png',

                onTap: () => widget.onNavigate(9),
              ),
            ],
          ),
          const Divider(thickness: 3, height: 20),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getTranslatedText('highlights', isEnglish),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          ///STEM HIGHLIGHT CAROUSEL (DATABASE)
          highlights.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : CarouselSlider(
                  items: highlights.map((item) {
                    return GestureDetector(
                      onTap: () => widget.onHighlightTap(item),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(item['media'][0], fit: BoxFit.fill),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Text(
                                item['highlight_title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentHighlightIndex = index;
                      });
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTopBar(bool isEnglish, FlutterLocalization localization) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: STEMXplore F2 Logo
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: const Text(
                  "STEMXplore ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF3E5F44),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "F3",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          // Right Side: Flag Toggle with Shadow (Matching Info Page)
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

class FeatureCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final String? imagePath;

  const FeatureCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableHeight = constraints.maxHeight;
        double imageSize = availableHeight * 0.60;
        double fontSize = availableHeight * 0.15;

        return Material(
          color: const Color.fromARGB(255, 52, 137, 55),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imagePath != null)
                  Image.asset(
                    imagePath!,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.contain,
                  )
                else
                  Icon(icon, size: imageSize, color: Colors.black87),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize.clamp(12, 16),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
