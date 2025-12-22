import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

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

          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                highlightCard('STEM in Daily Life'),
                highlightCard('Fun Science Facts'),
                highlightCard('Future STEM Careers'),
              ],
            ),
          ),
          SizedBox(height: 30),

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
              ),
              FeatureCard(
                imagePath: 'assets/images/learningmaterial.png',
                title: ' Learning Material',
              ),
              FeatureCard(
                imagePath: 'assets/images/gameicon.png',
                title: 'Quiz Games',
              ),
              FeatureCard(
                imagePath: 'assets/images/career.png',
                title: 'STEM Careers',
              ),
              FeatureCard(
                imagePath: 'assets/images/dailychallengeicon.png',
                title: 'Daily Challenge',
              ),
              FeatureCard(imagePath: 'assets/images/faqicon.png', title: 'FAQ'),
            ],
          ),
        ],
      ),
    );
  }

  Widget highlightCard(String title) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String imagePath;
  final String title;

  const FeatureCard({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
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
