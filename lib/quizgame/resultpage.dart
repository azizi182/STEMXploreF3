import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/theme_provider.dart';

class QuizResultPage extends StatefulWidget {
  final int score;
  final int total;
  final VoidCallback onBackHome;

  const QuizResultPage({
    super.key,
    required this.score,
    required this.total,
    required this.onBackHome,
  });

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    final theme = Theme.of(context);

    double percentage = widget.score / widget.total * 100;

    String message;
    if (percentage >= 80) {
      message = isEnglish ? "🎉 Wahhh! Excellent! 🌟" : "🎉 Wahhh! Hebat! 🌟";
    } else if (percentage >= 50) {
      message = isEnglish
          ? "😊 Good job! Keep improving!"
          : "😊 Kerja baik! Teruskan meningkat!";
    } else {
      message = isEnglish
          ? "😅 Don’t worry! Try again!"
          : "😅 Jangan risau! Cuba lagi!";
    }

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    isEnglish
                        ? "Score: ${widget.score} / ${widget.total}"
                        : "Skor: ${widget.score} / ${widget.total}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      widget.onBackHome();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      isEnglish ? "Back to Home" : "Kembali ke Rumah",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            // Confetti animation
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
