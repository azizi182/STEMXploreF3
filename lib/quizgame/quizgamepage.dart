import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:stemxplore/ipaddress.dart';
import 'package:stemxplore/quizgame/quizstartpage.dart';
import 'package:stemxplore/theme_provider.dart';

class Quizgamepage extends StatefulWidget {
  const Quizgamepage({super.key});

  @override
  State<Quizgamepage> createState() => _QuizgamepageState();
}

class _QuizgamepageState extends State<Quizgamepage> {
  String selectedCategory = "All";

  List quizzes = [];
  bool isLoading = true;

  Future<void> fetchQuiz() async {
    try {
      final response = await http.get(
        Uri.parse('${ipaddress.baseUrl}api/get_quiz.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          quizzes = data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load quiz');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  String getSubjectCover({
    required String subjectEn,
    required String subjectMs,
    required bool isEnglish,
  }) {
    if (subjectEn == "Science" || subjectMs == "Sains") {
      return isEnglish
          ? "assets/images/sains_cover_en.jpg"
          : "assets/images/sains_cover.jpg";
    }

    if (subjectEn == "Mathematics" || subjectMs == "Matematik") {
      return isEnglish
          ? "assets/images/mt_cover_en.jpg"
          : "assets/images/mt_cover.jpg";
    }

    if (subjectEn == "Fundamentals of Computer Science" ||
        subjectMs == "Asas Sains Komputer") {
      return isEnglish
          ? "assets/images/ask_cover.jpg"
          : "assets/images/ask_cover.jpg";
    }

    if (subjectEn == "Design And Technology" ||
        subjectMs == "Reka Bentuk Dan Teknologi") {
      return isEnglish
          ? "assets/images/rbt_cover.jpg"
          : "assets/images/rbt_cover.jpg";
    }

    return "assets/images/default_cover.jpg";
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    final theme = Theme.of(context);

    final filteredQuizzes =
        (selectedCategory == "All" || selectedCategory == "Semua")
        ? quizzes
        : quizzes.where((item) {
            final subjectEn = item['quiz_subject_en'];
            final subjectMs = item['quiz_subject_ms'];

            switch (selectedCategory) {
              case "Science":
              case "Sains":
                return subjectEn == "Science" || subjectMs == "Sains";

              case "Mathematics":
              case "Matematik":
                return subjectEn == "Mathematics" || subjectMs == "Matematik";

              case "Fundamentals of Computer Science":
              case "Asas Sains Komputer":
                return subjectEn == "Fundamentals of Computer Science" ||
                    subjectMs == "Asas Sains Komputer";

              case "Design And Technology":
              case "Reka Bentuk Dan Teknologi":
                return subjectEn == "Design And Technology" ||
                    subjectMs == "Reka Bentuk Dan Teknologi";

              default:
                return false;
            }
          }).toList();

    return GradientBackground(
      child: Scaffold(
        appBar: buildCustomAppBar(isEnglish, context),
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),

              _buildCategoryTabs(isEnglish),
              SizedBox(height: 10),

              Expanded(
                child: filteredQuizzes.isEmpty
                    ? ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          Center(
                            child: Text(
                              isEnglish
                                  ? "No quizzes found."
                                  : "Tiada kuiz dijumpai.",
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: filteredQuizzes.map((quiz) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizStartPage(
                                    quizId: quiz['quiz_id'].toString(),
                                    quizTitle: isEnglish
                                        ? quiz['quiz_title_en']
                                        : quiz['quiz_title_ms'],
                                  ),
                                ),
                              );
                            },
                            child: _quizCard(
                              title: isEnglish
                                  ? quiz['quiz_title_en']
                                  : quiz['quiz_title_ms'],
                              sub: "${quiz['quiz_total_question']} questions",

                              imgPath: getSubjectCover(
                                subjectEn: quiz['quiz_subject_en'],
                                subjectMs: quiz['quiz_subject_ms'],
                                isEnglish: isEnglish,
                              ),
                              isEnglish: isEnglish,
                            ),
                          );
                        }).toList(),
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

  Widget _quizCard({
    required String title,
    required String sub,
    required String imgPath,
    required bool isEnglish,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TEXT SIDE
          Expanded(
            child: Column(
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
                const SizedBox(height: 4),
                Text(
                  sub,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 8),

                /// OPTIONAL GAME BADGE
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 52, 137, 55),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isEnglish ? "Start Quiz" : "Mula Kuiz",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          /// IMAGE SIDE
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
                child: const Icon(Icons.quiz, color: Colors.grey, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
