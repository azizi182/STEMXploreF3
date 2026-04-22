import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/database/dao/quiz_dao.dart';
import 'package:stemxplore/theme_provider.dart';

class Quizgamepage extends StatefulWidget {
  final Function(String, String) onQuizStart;
  const Quizgamepage({super.key, required this.onQuizStart});

  @override
  State<Quizgamepage> createState() => _QuizgamepageState();
}

class _QuizgamepageState extends State<Quizgamepage> {
  String selectedCategory = "All";

  List quizzes = [];
  bool isLoading = true;

  Future<void> fetchQuiz() async {
    try {
      final data = await QuizDao.getAllQuizzes();

      setState(() {
        quizzes = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Quiz load error: $e");
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
    required int quizId,
    required bool isEnglish,
  }) {
    if (subjectEn == "Science" || subjectMs == "Sains") {
      switch (quizId) {
        case 1:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap1.png"
              : "assets/images/cover_chap/sn/chap1ms.png";

        case 3:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap2.png"
              : "assets/images/cover_chap/sn/chap2ms.png";

        case 4:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap3.png"
              : "assets/images/cover_chap/sn/chap3ms.png";

        case 5:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap4.png"
              : "assets/images/cover_chap/sn/chap4ms.png";

        case 6:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap5.png"
              : "assets/images/cover_chap/sn/chap5ms.png";

        case 7:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap6.png"
              : "assets/images/cover_chap/sn/chap6ms.png";

        case 8:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap7.png"
              : "assets/images/cover_chap/sn/chap7ms.png";

        case 9:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap8.png"
              : "assets/images/cover_chap/sn/chap8ms.png";

        case 10:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap9.png"
              : "assets/images/cover_chap/sn/chap9ms.png";

        case 11:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap10.png"
              : "assets/images/cover_chap/sn/chap10ms.png";

        default:
          return isEnglish
              ? "assets/images/cover_chap/sn/chap_default.png"
              : "assets/images/cover_chap/sn/chap_defaultms.png";
      }
    }

    if (subjectEn == "Mathematics" || subjectMs == "Matematik") {
      switch (quizId) {
        case 2:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap1.png"
              : "assets/images/cover_chap/mt/chap1ms.png";

        case 12:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap2.png"
              : "assets/images/cover_chap/mt/chap2ms.png";
        case 13:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap3.png"
              : "assets/images/cover_chap/mt/chap3ms.png";

        case 14:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap4.png"
              : "assets/images/cover_chap/mt/chap4ms.png";

        case 15:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap5.png"
              : "assets/images/cover_chap/mt/chap5ms.png";

        case 16:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap6.png"
              : "assets/images/cover_chap/mt/chap6ms.png";

        case 17:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap7.png"
              : "assets/images/cover_chap/mt/chap7ms.png";

        case 18:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap8.png"
              : "assets/images/cover_chap/mt/chap8ms.png";

        case 19:
          return isEnglish
              ? "assets/images/cover_chap/mt/chap9.png"
              : "assets/images/cover_chap/mt/chap9ms.png";
      }
    }

    if (subjectEn == "Fundamentals of Computer Science" ||
        subjectMs == "Asas Sains Komputer") {
      switch (quizId) {
        case 20:
          return isEnglish
              ? "assets/images/cover_chap/ask/chap1.png"
              : "assets/images/cover_chap/ask/chap1ms.png";
        case 21:
          return isEnglish
              ? "assets/images/cover_chap/ask/chap2.png"
              : "assets/images/cover_chap/ask/chap2ms.png";
        case 22:
          return isEnglish
              ? "assets/images/cover_chap/ask/chap3.png"
              : "assets/images/cover_chap/ask/chap3ms.png";
        case 23:
          return isEnglish
              ? "assets/images/cover_chap/ask/chap4.png"
              : "assets/images/cover_chap/ask/chap4ms.png";
      }
    }

    if (subjectEn == "Design And Technology" ||
        subjectMs == "Reka Bentuk Dan Teknologi") {
      switch (quizId) {
        case 24:
          return isEnglish
              ? "assets/images/cover_chap/rbt/chap1.png"
              : "assets/images/cover_chap/rbt/chap1ms.png";
        case 25:
          return isEnglish
              ? "assets/images/cover_chap/rbt/chap2.png"
              : "assets/images/cover_chap/rbt/chap2ms.png";
        case 26:
          return isEnglish
              ? "assets/images/cover_chap/rbt/chap3.png"
              : "assets/images/cover_chap/rbt/chap3ms.png";
      }
    }
    return isEnglish
        ? "assets/images/cover_chap/default/chap_default.png"
        : "assets/images/cover_chap/default/chap_defaultms.png";
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
                              widget.onQuizStart(
                                quiz['quiz_id'].toString(),
                                isEnglish
                                    ? quiz['quiz_title_en']
                                    : quiz['quiz_title_ms'],
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
                                quizId: quiz['quiz_id'] as int,
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
