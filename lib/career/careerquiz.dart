import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/theme_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stemxplore/ipaddress.dart';
import 'package:stemxplore/career/careerresult.dart';

class Careerquiz extends StatefulWidget {
  final Function(int) onFinishCareerQuiz;

  const Careerquiz({super.key, required this.onFinishCareerQuiz});
  @override
  State<Careerquiz> createState() => _CareerquizState();
}

class _CareerquizState extends State<Careerquiz> {
  int currentQuestion = 0;
  List questions = [];
  bool isLoading = true;

  Map<int, int> fieldScore = {
    1: 0, // science
    2: 0, // technology
    3: 0, // engineering
    4: 0, // math
  };

  List<Map<dynamic, dynamic>> getOptions(Map question, bool isEnglish) {
    return [
      {
        "text": isEnglish ? question['option1_en'] : question['option1_ms'],
        "field": question['option1_field'],
      },
      {
        "text": isEnglish ? question['option2_en'] : question['option2_ms'],
        "field": question['option2_field'],
      },
      {
        "text": isEnglish ? question['option3_en'] : question['option3_ms'],
        "field": question['option3_field'],
      },
      {
        "text": isEnglish ? question['option4_en'] : question['option4_ms'],
        "field": question['option4_field'],
      },
    ].where((opt) => opt['text'] != null && opt['text']!.isNotEmpty).toList();
  }

  List<int?> selectedAnswers = [];

  Future<void> fetchQuestions() async {
    final response = await http.get(
      Uri.parse("${ipaddress.baseUrl}api/get_career_question.php"),
    );
    //print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (!mounted) return; // safety check before setState
      setState(() {
        questions = data;
        selectedAnswers = List<int?>.filled(questions.length, null);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  void selectAnswer(int fieldId) {
    setState(() {
      selectedAnswers[currentQuestion] = fieldId;
    });
  }

  void goNext() {
    if (selectedAnswers[currentQuestion] == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an answer")));
      return;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      finishQuiz();
    }
  }

  void goBack() {
    if (currentQuestion > 0) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void finishQuiz() {
    Map<int, int> score = {1: 0, 2: 0, 3: 0, 4: 0};

    for (var field in selectedAnswers) {
      if (field != null) {
        score[field] = score[field]! + 1;
      }
    }

    int bestField = 1;
    int highest = 0;

    score.forEach((field, value) {
      if (value > highest) {
        highest = value;
        bestField = field;
      }
    });

    widget.onFinishCareerQuiz(bestField);
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    final theme = Theme.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (questions.isEmpty) {
      return Center(
        child: Text(
          isEnglish ? "No questions found." : "Tiada soalan dijumpai.",
          style: const TextStyle(fontSize: 18),
        ),
      );
    }

    final options = isLoading || questions.isEmpty
        ? []
        : getOptions(questions[currentQuestion], isEnglish);

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: buildCustomAppBar(isEnglish, context),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// PROGRESS BAR
              LinearProgressIndicator(
                value: (currentQuestion + 1) / questions.length,
                backgroundColor: Colors.grey[300],
                minHeight: 6,
              ),

              const SizedBox(height: 20),

              /// CENTER CONTENT
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// QUESTION CARD
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Question ${currentQuestion + 1} / ${questions.length}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  isEnglish
                                      ? questions[currentQuestion]["cquestion_en"] ??
                                            ""
                                      : questions[currentQuestion]["cquestion_ms"] ??
                                            "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// ANSWER OPTIONS
                          ...options.asMap().entries.map((entry) {
                            int index = entry.key;
                            var option = entry.value;

                            bool isSelected =
                                selectedAnswers[currentQuestion] ==
                                (int.tryParse(
                                      option["field"]?.toString() ?? "0",
                                    ) ??
                                    0);

                            /// Base color (always colorful)
                            Color baseColor;
                            Color selectedColor;

                            switch (index % 4) {
                              case 0:
                                baseColor = Colors.blue.shade100;
                                selectedColor = Colors.blue.shade400;
                                break;
                              case 1:
                                baseColor = Colors.green.shade100;
                                selectedColor = Colors.green.shade400;
                                break;
                              case 2:
                                baseColor = Colors.orange.shade100;
                                selectedColor = Colors.orange.shade400;
                                break;
                              default:
                                baseColor = Colors.pink.shade100;
                                selectedColor = Colors.pink.shade400;
                            }

                            return GestureDetector(
                              onTap: () {
                                final fieldId =
                                    int.tryParse(
                                      option["field"]?.toString() ?? "0",
                                    ) ??
                                    0;
                                if (fieldId != 0) selectAnswer(fieldId);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),

                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? selectedColor
                                      : baseColor, // ✅ always colorful
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: isSelected
                                        ? selectedColor
                                        : baseColor,
                                    width: 2,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: selectedColor.withOpacity(
                                              0.4,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : [],
                                ),

                                child: Text(
                                  option["text"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87, // ✅ contrast
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// BOTTOM BUTTONS (FIXED)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: currentQuestion > 0 ? goBack : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: goNext,
                      child: Text(
                        currentQuestion == questions.length - 1
                            ? "Finish"
                            : "Next",
                      ),
                    ),
                  ],
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
          isEnglish ? "Choice Your Career" : 'Pilih Karier Anda',
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
