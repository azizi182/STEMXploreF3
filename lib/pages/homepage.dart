import 'package:flutter/material.dart';
// import feature pages
import 'package:stemxplore/career/careerpage.dart';
import 'package:stemxplore/dailychallenge/dailychallengepage.dart';
import 'package:stemxplore/faq/faqpage.dart';
import 'package:stemxplore/learningmaterial/learningmaterialpage.dart';
import 'package:stemxplore/quizgame/quizgamepage.dart';
import 'package:stemxplore/steminfo/steminfopage.dart';
// carousel slider import
import 'package:carousel_slider/carousel_slider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // highlight
  late List highlightTitles = [
    'STEM in Daily Life',
    'Fun Science Facts',
    'Future STEM Careers',
  ];

  int currentHighlightIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          // caroutsell input
          Text(
            'STEM Highlights',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12),

          CarouselSlider(
            items: highlightTitles.map((title) {
              return highlightCard(title);
            }).toList(),
            options: CarouselOptions(
              height: 150,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentHighlightIndex = index;
                });
              },
            ),
          ),

          Text(
            'Explore Features',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureCard(
                imagePath: 'assets/images/infostem.png',
                title: 'STEM Info',
                destinationPage: const Steminfopage(),
              ),
              FeatureCard(
                imagePath: 'assets/images/learningmaterial.png',
                title: ' Learning Material',
                destinationPage: const Learningmaterialpage(),
              ),
              FeatureCard(
                imagePath: 'assets/images/gameicon.png',
                title: 'Quiz Games',
                destinationPage: const Quizgamepage(),
              ),
              FeatureCard(
                imagePath: 'assets/images/career.png',
                title: 'STEM Careers',
                destinationPage: const Careerpage(),
              ),
              FeatureCard(
                imagePath: 'assets/images/dailychallengeicon.png',
                title: 'Daily Challenge',
                destinationPage: const Dailychallengepage(),
              ),
              FeatureCard(
                imagePath: 'assets/images/faqicon.png',
                title: 'FAQ',
                destinationPage: const Faqpage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget highlightCard(String title) {
    return SizedBox(
      width: 300,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Widget destinationPage;

  const FeatureCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.destinationPage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },

        borderRadius: BorderRadius.circular(12),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.contain),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
