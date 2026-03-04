import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/theme_provider.dart';

class Quizgamepage extends StatefulWidget {
  const Quizgamepage({super.key});

  @override
  State<Quizgamepage> createState() => _QuizgamepageState();
}

class _QuizgamepageState extends State<Quizgamepage> {
  String selectedCategory = "All";
  final List<String> categories = [
    "All",
    "Science",
    "Mathematics",
    "Asas Sains Komputer",
    "Reka Bentuk Dan Teknologi",
  ];

  final List<Map<String, String>> quizzes = [
    {
      "title": "STEM",
      "sub": "10 questions",
      "image": "assets/images/quiz_stem.png",
      "category": "All",
    },
    {
      "title": "Mathematics Form 3",
      "sub": "15 questions",
      "image": "assets/images/mt_cover.png",
      "category": "Mathematics",
    },
    {
      "title": "Science Form 3",
      "sub": "15 questions",
      "image": "assets/images/sains_cover.png",
      "category": "Science",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        appBar: buildCustomAppBar(isEnglish, context),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildCategoryTabs(isEnglish),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: quizzes
                      .where(
                        (quiz) =>
                            selectedCategory == "All" ||
                            quiz['category'] == selectedCategory,
                      )
                      .map((quiz) {
                        return GestureDetector(
                          onTap: () {
                            if (quiz['title'] == "Science Form 3") {}
                          },
                          child: _quizCard(
                            quiz['title']!,
                            quiz['sub']!,
                            quiz['image']!,
                          ),
                        );
                      })
                      .toList(),
                ),
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
          isEnglish ? "Quiz Game" : 'Permainan Kuiz',
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

  Widget _buildCategoryTabs(bool isEnglish) {
    final List<String> displaySubjects = isEnglish
        ? [
            "All",
            "Science",
            "Mathematics",
            "Fundamentals of Computer Science",
            "Design And Technology",
          ]
        : [
            "Semua",
            "Sains",
            "Matematik",
            "Asas Sains Komputer",
            "Reka Bentuk Dan Teknologi",
          ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: displaySubjects.length,
        itemBuilder: (context, index) {
          final displayText = displaySubjects[index];
          bool isSelected = selectedCategory == displayText;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = displayText;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                displayText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.black : Colors.black54,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _quizCard(String title, String sub, String imgPath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withValues(alpha: .05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15), // Gap between text and image

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imgPath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Icon(Icons.book, color: Colors.grey, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
