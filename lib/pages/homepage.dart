import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stemxplore/ipaddress.dart';

import 'package:stemxplore/stemhighlight/stem_highlight.dart';

class Homepage extends StatefulWidget {
  final Function(int) onNavigate;

  const Homepage({super.key, required this.onNavigate});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List highlights = [];
  int currentHighlightIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchStemHighlights();
  }

  Future<void> fetchStemHighlights() async {
    final response = await http.get(
      Uri.parse('${ipaddress.baseUrl}api/get_stem_highlight.php'),
    );

    if (response.statusCode == 200) {
      setState(() {
        highlights = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          const Text(
            'STEM Highlights',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ///STEM HIGHLIGHT CAROUSEL (DATABASE)
          highlights.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : CarouselSlider(
                  items: highlights.map((item) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StemHighlight(data: item),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(item['media'][0], fit: BoxFit.cover),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 12,
                              child: Text(
                                item['highlight_title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentHighlightIndex = index;
                      });
                    },
                  ),
                ),

          const SizedBox(height: 20),

          const Text(
            'Explore Features',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          ///FEATURES GRID (UNCHANGED)
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              FeatureCard(
                imagePath: 'assets/images/infostem.png',
                title: 'STEM Info',
                onTap: () => widget.onNavigate(3),
              ),
              FeatureCard(
                imagePath: 'assets/images/learningmaterial.png',
                title: 'Learning Material',
                onTap: () => widget.onNavigate(4),
              ),
              FeatureCard(
                imagePath: 'assets/images/gameicon.png',
                title: 'Quiz Games',
                onTap: () => widget.onNavigate(5),
              ),
              FeatureCard(
                imagePath: 'assets/images/career.png',
                title: 'STEM Careers',
                onTap: () => widget.onNavigate(6),
              ),
              FeatureCard(
                imagePath: 'assets/images/dailychallengeicon.png',
                title: 'Daily Challenge',
                onTap: () => widget.onNavigate(7),
              ),
              FeatureCard(
                imagePath: 'assets/images/faqicon.png',
                title: 'FAQ',
                onTap: () => widget.onNavigate(8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 80, height: 80),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
