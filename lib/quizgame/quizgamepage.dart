import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/gradient_background.dart';

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
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              _buildCategoryScroll(),
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

  Widget _buildAppBar() {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    return AppBar(
      title: Text(
        isEnglish ? 'Quiz Game' : 'Permainan Kuiz',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [const SizedBox(width: 8)],
    );
  }

  Widget _buildCategoryScroll() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
              ),
              child: Text(
                categories[index],
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
