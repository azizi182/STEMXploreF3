import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stemxplore/database/dao/highlight_dao.dart';
import 'package:stemxplore/theme_provider.dart';

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
    loadHighlights();
  }

  Future<void> loadHighlights() async {
    try {
      final data = await HighlightDao.getHighlights();

      setState(() {
        highlights = data;
        print("Highlights length: ${data.length}");
      });
    } catch (e) {
      print("Error loading highlights: $e");
    }
  }

  String _getTranslatedText(String key, bool isEnglish) {
    final Map<String, Map<String, String>> localizedValues = {
      'stemInfo': {'en': 'STEM Info', 'ms': 'Info STEM'},
      'learning': {'en': 'Learning Material', 'ms': 'Bahan Pembelajaran'},
      'quiz': {'en': 'Quiz', 'ms': 'Kuiz'},
      'careers': {'en': 'STEM Careers', 'ms': 'Kerjaya STEM'},
      'challenge': {'en': 'Daily Info', 'ms': 'Info Harian'},
      'faq': {'en': 'FAQ', 'ms': 'Soalan Lazim'},
      'highlights': {'en': 'STEM Highlights:', 'ms': 'Sorotan STEM:'},
      'readMore': {'en': 'Read more', 'ms': 'Baca lagi'},
    };
    return localizedValues[key]?[isEnglish ? 'en' : 'ms'] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final theme = Theme.of(context);

    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildTopBar(isEnglish, localization, theme, isDark),

          GridView.count(
            childAspectRatio: 1.15,
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureCard(
                label: _getTranslatedText('stemInfo', isEnglish),
                icon: Icons.science,
                imagePath: 'assets/images/infostem2.png',
                backgroundColor: theme.brightness == Brightness.dark
                    ? Color.fromRGBO(179, 204, 161, 1)
                    : Color.fromARGB(255, 52, 137, 55),
                onTap: () => widget.onNavigate(4),
              ),
              FeatureCard(
                label: _getTranslatedText('learning', isEnglish),
                icon: Icons.menu_book,
                imagePath: 'assets/images/learningmaterial2.png',
                backgroundColor: theme.brightness == Brightness.dark
                    ? Color.fromRGBO(179, 204, 161, 1)
                    : Color.fromARGB(255, 52, 137, 55),
                onTap: () => widget.onNavigate(5),
              ),
              FeatureCard(
                label: _getTranslatedText('quiz', isEnglish),
                icon: Icons.question_answer,
                imagePath: 'assets/images/quizicon2.png',
                backgroundColor: theme.brightness == Brightness.dark
                    ? Color.fromRGBO(179, 204, 161, 1)
                    : Color.fromARGB(255, 52, 137, 55),
                onTap: () => widget.onNavigate(6),
              ),
              FeatureCard(
                label: _getTranslatedText('careers', isEnglish),
                icon: Icons.work,
                imagePath: 'assets/images/career2.png',
                backgroundColor: theme.brightness == Brightness.dark
                    ? Color.fromRGBO(179, 204, 161, 1)
                    : Color.fromARGB(255, 52, 137, 55),
                onTap: () => widget.onNavigate(7),
              ),
              FeatureCard(
                label: _getTranslatedText('challenge', isEnglish),
                icon: Icons.calendar_today,
                imagePath: 'assets/images/dailychallengeicon2.png',
                backgroundColor: theme.brightness == Brightness.dark
                    ? Color.fromRGBO(179, 204, 161, 1)
                    : Color.fromARGB(255, 52, 137, 55),
                onTap: () => widget.onNavigate(8),
              ),
              FeatureCard(
                label: _getTranslatedText('faq', isEnglish),
                icon: Icons.help_center_outlined,
                imagePath: 'assets/images/faqicon2.png',
                backgroundColor: theme.brightness == Brightness.dark
                    ? Color.fromRGBO(179, 204, 161, 1)
                    : Color.fromARGB(255, 52, 137, 55),
                onTap: () => widget.onNavigate(9),
              ),
            ],
          ),
          const Divider(thickness: 3, height: 20),

          Text(
            _getTranslatedText('highlights', isEnglish),
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          /// STEM HIGHLIGHT CAROUSEL
          highlights.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 170,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: highlights.length,
                    itemBuilder: (context, index) {
                      final item = highlights[index];
                      final mediaList = item['media'] ?? [];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        child: GestureDetector(
                          onTap: () => widget.onHighlightTap(item),

                          child: Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF535252)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: isDark
                                  ? []
                                  : [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                            ),

                            child: Row(
                              children: [
                                /// LEFT IMAGE
                                SizedBox(
                                  width: 130,
                                  height: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      mediaList.isNotEmpty
                                          ? mediaList[0]
                                          : 'assets/images/logoicon4.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                /// RIGHT TEXT
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// TITLE
                                        Text(
                                          isEnglish
                                              ? item['highlight_title_en']
                                              : item['highlight_title_ms'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        /// SUBTITLE (if you have)
                                        Text(
                                          isEnglish
                                              ? item['highlight_subtitle_en'] ??
                                                    ''
                                              : item['highlight_subtitle_ms'] ??
                                                    '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: isDark
                                                ? Colors.white60
                                                : Colors.black54,
                                          ),
                                        ),

                                        const Spacer(),

                                        /// READ MORE
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            _getTranslatedText(
                                              'readMore',
                                              isEnglish,
                                            ),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTopBar(
    bool isEnglish,
    FlutterLocalization localization,
    ThemeData theme,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: STEMXplore Logo
          Row(
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: theme.brightness == Brightness.dark
                        ? const Color.fromRGBO(179, 204, 161, 1)
                        : Colors.black,
                  ),
                  children: const [
                    TextSpan(text: "STEM"),
                    TextSpan(text: "X", style: TextStyle(fontSize: 30)),
                    TextSpan(text: "plore "),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? Color.fromRGBO(179, 204, 161, 1)
                      : Color.fromARGB(255, 52, 137, 55),
                  shape: BoxShape.circle,
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.brightness == Brightness.dark
                          ? Color.fromARGB(255, 52, 137, 55)
                          : const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                    children: const [
                      TextSpan(text: "F", style: TextStyle(fontSize: 22)),
                      TextSpan(text: "3", style: TextStyle(fontSize: 30)),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Right Side: Flag Toggle
          GestureDetector(
            onTap: () {
              final localization = FlutterLocalization.instance;

              final currentLang =
                  localization.currentLocale?.languageCode ?? 'en';
              final newLang = currentLang == 'en' ? 'ms' : 'en';

              localization.translate(newLang);

              setState(() {});
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔵 Circle (ONLY flag inside)
                ClipOval(
                  child: Image.asset(
                    isEnglish
                        ? 'assets/flag/language ms_flag.png'
                        : 'assets/flag/language us_flag.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                ),

                // 🔤 Text BELOW the circle
                Text(
                  isEnglish ? 'MS' : 'EN',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
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
  final Color backgroundColor;

  const FeatureCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.imagePath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        double availableHeight = constraints.maxHeight;
        double imageSize = availableHeight * 0.60;
        double fontSize = availableHeight * 0.15;

        return Material(
          color: backgroundColor,
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
                  Icon(
                    icon,
                    size: imageSize,
                    color: theme.brightness == Brightness.dark
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : Colors.black87,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize.clamp(12, 20),
                      fontWeight: FontWeight.bold,
                      color: theme.brightness == Brightness.dark
                          ? Color.fromARGB(255, 52, 137, 55)
                          : Colors.black87,
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
