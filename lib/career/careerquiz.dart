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
          padding: const EdgeInsets.all(20),

          child: Column(
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
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Question ${currentQuestion + 1}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Text(
                          "${currentQuestion + 1} / ${questions.length}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      isEnglish
                          ? questions[currentQuestion]["cquestion_en"] ?? ""
                          : questions[currentQuestion]["cquestion_ms"] ?? "",

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// OPTIONS
              ...options.asMap().entries.map((entry) {
                int index = entry.key;
                var option = entry.value;

                bool isSelected =
                    selectedAnswers[currentQuestion] ==
                    (int.tryParse(option["field"]?.toString() ?? "0") ?? 0);

                Color optionColor;

                switch (index % 4) {
                  case 0:
                    optionColor = isSelected
                        ? Colors.blue.shade300
                        : Colors.blue.shade50;
                    break;

                  case 1:
                    optionColor = isSelected
                        ? Colors.green.shade300
                        : Colors.green.shade50;
                    break;

                  case 2:
                    optionColor = isSelected
                        ? Colors.orange.shade300
                        : Colors.orange.shade50;
                    break;

                  default:
                    optionColor = isSelected
                        ? Colors.pink.shade300
                        : Colors.pink.shade50;
                }

                return GestureDetector(
                  onTap: () {
                    final fieldId =
                        int.tryParse(option["field"]?.toString() ?? "0") ?? 0;
                    if (fieldId != 0) selectAnswer(fieldId);
                  },

                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black12),
                    ),

                    child: Text(
                      option["text"],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              /// NAVIGATION BUTTONS
              Row(
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
