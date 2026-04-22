import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/database/dao/quiz_question_dao.dart';
import 'package:stemxplore/theme_provider.dart';

class QuizStartPage extends StatefulWidget {
  final String quizTitle;
  final String quizId;
  final Function(int, int) onFinishQuiz;

  const QuizStartPage({
    super.key,
    required this.quizTitle,
    required this.quizId,
    required this.onFinishQuiz,
  });

  @override
  State<QuizStartPage> createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage> {
  int currentQuestion = 0;
  int score = 0;
  List<Map<String, dynamic>> questions = [];
  List<String?> selectedAnswers = [];
  bool isLoading = true;
  List<bool> showResults = [];
  List<String?> correctAnswers = [];
  List<bool> isCorrectList = [];
  List<List<Map<String, dynamic>>> shuffledOptions = [];

  List<Map<String, dynamic>> getOptions(
    Map<String, dynamic> question,
    bool isEnglish,
  ) {
    List<Map<String, dynamic>> options = [
      {
        "text": isEnglish ? question['opt_a_en'] : question['opt_a_ms'],
        "image": question['opt_a_image'],
      },
      {
        "text": isEnglish ? question['opt_b_en'] : question['opt_b_ms'],
        "image": question['opt_b_image'],
      },
      {
        "text": isEnglish ? question['opt_c_en'] : question['opt_c_ms'],
        "image": question['opt_c_image'],
      },
      {
        "text": isEnglish ? question['opt_d_en'] : question['opt_d_ms'],
        "image": question['opt_d_image'],
      },
    ].where((opt) => opt['text'] != null && opt['text']!.isNotEmpty).toList();

    options.shuffle(); // 🔥 RANDOMIZE ANSWERS

    return options;
  }

  Future<void> fetchQuestions() async {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final isEnglish = localization.currentLocale?.languageCode == 'en';
    try {
      final data = await QuizDetailDao.getQuizWithQuestions(
        int.parse(widget.quizId),
      );

      setState(() {
        questions = data;
        questions = List<Map<String, dynamic>>.from(data);
        questions.shuffle();

        if (questions.isEmpty) {
          isLoading = false;
          return;
        }

        shuffledOptions = questions.map((q) {
          var opts = getOptions(q, isEnglish);
          opts.shuffle();
          return opts;
        }).toList();

        selectedAnswers = List<String?>.filled(questions.length, null);
        showResults = List<bool>.filled(questions.length, false);
        correctAnswers = List<String?>.filled(questions.length, null);
        isCorrectList = List<bool>.filled(questions.length, false);

        isLoading = false;
        print("QUESTIONS FROM DB: $data");
      });
    } catch (e) {
      print("DB error: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  void selectAnswer(String answer) {
    if (selectedAnswers.isEmpty || currentQuestion >= selectedAnswers.length) {
      // Safety check
      return;
    }

    setState(() {
      selectedAnswers[currentQuestion] = answer; // Save user selection
    });
  }

  void goNext() {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    if (selectedAnswers[currentQuestion] == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an answer")));
      return;
    }

    String correct = isEnglish
        ? questions[currentQuestion]['correct_answer_en']
        : questions[currentQuestion]['correct_answer_ms'];
    String selected = selectedAnswers[currentQuestion]!;

    bool correctStatus = selected == correct;

    setState(() {
      showResults[currentQuestion] = true;
      correctAnswers[currentQuestion] = correct;
      isCorrectList[currentQuestion] = correctStatus;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(
          child: Text(
            correctStatus ? "✅ Correct!" : "❌ Wrong!",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }

  void goBack() {
    if (currentQuestion > 0) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void finishQuiz() {
    // Check unanswered questions
    List<int> unanswered = [];
    for (int i = 0; i < selectedAnswers.length; i++) {
      if (selectedAnswers[i] == null) unanswered.add(i + 1);
    }

    if (unanswered.isNotEmpty) {
      // Show alert with unanswered question numbers
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Incomplete"),
          content: Text(
            "You haven't answered questions: ${unanswered.join(', ')}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    // Calculate score
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['correct_answer_en'] ||
          selectedAnswers[i] == questions[i]['correct_answer_ms']) {
        score++;
      }
    }

    // Show result
    widget.onFinishQuiz(score, questions.length);
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (questions.isEmpty || shuffledOptions.isEmpty) {
      return GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context, isEnglish, widget.quizTitle),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isEnglish
                      ? "No questions found for this quiz yet."
                      : "Tiada soalan dijumpai untuk kuiz ini lagi.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final options = shuffledOptions[currentQuestion];

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: _buildAppBar(context, isEnglish, widget.quizTitle),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              /// ✅ PROGRESS BAR
              LinearProgressIndicator(
                value: (currentQuestion + 1) / questions.length,
                backgroundColor: Colors.grey[300],
                minHeight: 6,
              ),

              const SizedBox(height: 20),

              /// ✅ CENTER CONTENT (same style as career quiz)
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
                                      ? questions[currentQuestion]['question_text_en']
                                      : questions[currentQuestion]['question_text_ms'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 15),

                                if (questions[currentQuestion]['question_image'] !=
                                        null &&
                                    questions[currentQuestion]['question_image']
                                        .isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      questions[currentQuestion]['question_image'],
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// ✅ OPTIONS (COLORFUL + RESULT)
                          ...options.asMap().entries.map((entry) {
                            int index = entry.key;
                            var option = entry.value;

                            bool isSelected =
                                selectedAnswers[currentQuestion] ==
                                option['text'];

                            bool show = showResults[currentQuestion];
                            bool isCorrect =
                                option['text'] ==
                                correctAnswers[currentQuestion];

                            /// 🎨 COLORS
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

                            /// ✅ RESULT COLOR LOGIC
                            Color finalColor = baseColor;

                            if (show) {
                              if (isCorrect) {
                                finalColor = Colors.green.shade400; // correct
                              } else if (isSelected) {
                                finalColor =
                                    Colors.red.shade400; // wrong selected
                              }
                            } else {
                              finalColor = isSelected
                                  ? selectedColor
                                  : baseColor;
                            }

                            return GestureDetector(
                              onTap: () {
                                if (!show) {
                                  selectAnswer(option['text']);
                                }
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: finalColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: finalColor.withOpacity(0.4),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  children: [
                                    if (option['image'] != null &&
                                        option['image']!.isNotEmpty)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          option['image'],
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                    if (option['image'] != null &&
                                        option['image']!.isNotEmpty)
                                      const SizedBox(height: 8),

                                    Text(
                                      option['text'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: show || isSelected
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),

                                    /// ✅ ICON FEEDBACK
                                    if (show)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Icon(
                                          isCorrect
                                              ? Icons.check_circle
                                              : isSelected
                                              ? Icons.cancel
                                              : null,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
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

              /// ✅ BOTTOM BUTTONS (same style)
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
                      onPressed: () {
                        if (!showResults[currentQuestion]) {
                          goNext(); // check answer
                        } else {
                          if (currentQuestion < questions.length - 1) {
                            setState(() {
                              currentQuestion++;
                            });
                          } else {
                            finishQuiz();
                          }
                        }
                      },
                      child: Text(
                        currentQuestion == questions.length - 1 &&
                                showResults[currentQuestion]
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
}

AppBar _buildAppBar(BuildContext context, bool isEnglish, String title) {
  final theme = Theme.of(context);
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            final localization = FlutterLocalization.instance;
            final currentLang =
                localization.currentLocale?.languageCode ?? 'en';
            final newLang = currentLang == 'en' ? 'ms' : 'en';
            localization.translate(newLang);
          },
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
      ],
    ),
    backgroundColor: theme.brightness == Brightness.dark
        ? Color.fromRGBO(179, 204, 161, 1)
        : Color.fromARGB(255, 52, 137, 55),
  );
}
