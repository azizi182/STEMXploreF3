import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:stemxplore/ipaddress.dart';
import 'package:stemxplore/quizgame/resultpage.dart';
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
  List questions = [];
  List<String?> selectedAnswers = [];
  bool isLoading = true;
  List<bool> showResults = [];
  List<String?> correctAnswers = [];
  List<bool> isCorrectList = [];
  List<Map<String, dynamic>> getOptions(Map question, bool isEnglish) {
    return [
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
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(
      Uri.parse(
        '${ipaddress.baseUrl}api/get_quiz_question.php?quiz_id=${widget.quizId}',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        questions = data;
        selectedAnswers = List<String?>.filled(questions.length, null);

        showResults = List<bool>.filled(questions.length, false);
        correctAnswers = List<String?>.filled(questions.length, null);
        isCorrectList = List<bool>.filled(questions.length, false);
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
    if (selectedAnswers[currentQuestion] == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please select an answer")));
      return;
    }

    String correct = questions[currentQuestion]['correct_answer_en'];
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

        appBar: _buildAppBar(context, isEnglish, widget.quizTitle),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
              children: [
                /// QUESTION CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? Colors.white
                        : Colors.white,
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
                      // Question Number + Progress
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Question ${currentQuestion + 1}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.black87
                                  : Colors.black87,
                            ),
                          ),
                          Text(
                            "${currentQuestion + 1} / ${questions.length}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Question Text
                      Text(
                        isEnglish
                            ? questions[currentQuestion]['question_text_en']
                            : questions[currentQuestion]['question_text_ms'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Question Image (if exists)
                      if (questions[currentQuestion]['question_image'] !=
                              null &&
                          questions[currentQuestion]['question_image']
                              .isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            questions[currentQuestion]['question_image'],
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                /// OPTIONS
                ...options.asMap().entries.map<Widget>((entry) {
                  int index = entry.key;
                  var option = entry.value;

                  // Highlight selected option
                  bool isSelected =
                      selectedAnswers.length > currentQuestion &&
                      selectedAnswers[currentQuestion] == option['text'];

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
                          ? Colors.yellow.shade300
                          : Colors.yellow.shade50;
                      break;
                    default:
                      optionColor = isSelected
                          ? Colors.pink.shade300
                          : Colors.pink.shade50;
                  }

                  return GestureDetector(
                    onTap: () => selectAnswer(option['text']!),

                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: optionColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black12),
                      ),

                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (option['image'] != null &&
                                    option['image']!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      option['image']!,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),

                                if (option['image'] != null &&
                                    option['image']!.isNotEmpty)
                                  const SizedBox(height: 8),

                                Text(
                                  option['text']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          /// RESULT ICON
                          if (showResults[currentQuestion])
                            Icon(
                              option['text'] == correctAnswers[currentQuestion]
                                  ? Icons.check_circle
                                  : selectedAnswers[currentQuestion] ==
                                        option['text']
                                  ? Icons.cancel
                                  : null,
                              color:
                                  option['text'] ==
                                      correctAnswers[currentQuestion]
                                  ? Colors.green
                                  : Colors.red,
                              size: 28,
                            ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 15),

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
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                    ElevatedButton(
                      child: Text(
                        showResults[currentQuestion] ? "Next" : "Next",
                      ),
                      onPressed: () {
                        if (!showResults[currentQuestion]) {
                          goNext(); // check answer first
                        } else {
                          if (currentQuestion < questions.length - 1) {
                            setState(() {
                              currentQuestion++;
                              showResults[currentQuestion] = false;
                            });
                          } else {
                            finishQuiz();
                          }
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),

                if (showResults[currentQuestion] &&
                    !isCorrectList[currentQuestion])
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      "Correct Answer: $correctAnswers",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
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
    backgroundColor: theme.brightness == Brightness.dark
        ? Color.fromRGBO(179, 204, 161, 1)
        : Color.fromARGB(255, 52, 137, 55),
  );
}
