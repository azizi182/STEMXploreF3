import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stemxplore/ipaddress.dart';

import 'package:stemxplore/stemhighlight/stem_highlight.dart';

class Homepage extends StatefulWidget {
  final Function(int) onNavigate;
  final Function(Map) onHighlightTap;

  const Homepage({
    super.key,
    required this.onNavigate,
    required this.onHighlightTap,
  });

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
          //languange
          IconButton(onPressed: () {}, icon: const Icon(Icons.language)),
          // const SizedBox(height: 10),

          ///FEATURES GRID (UNCHANGED)
          Container(
            padding: EdgeInsets.fromLTRB(
              10,
              0,
              10,
              10,
            ), // Padding around the grid(16),

            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 4, // vertical gap
              crossAxisSpacing: 4, // horizontal gap

              physics: const NeverScrollableScrollPhysics(),
              children: [
                FeatureCard(
                  imagePath: 'assets/images/infostem2.png',
                  title: 'STEM Info',
                  onTap: () => widget.onNavigate(3),
                ),
                FeatureCard(
                  imagePath: 'assets/images/learningmaterial2.png',
                  title: 'Learning Material',
                  onTap: () => widget.onNavigate(4),
                ),
                FeatureCard(
                  imagePath: 'assets/images/quizicon2.png',
                  title: 'Quiz',
                  onTap: () => widget.onNavigate(5),
                ),
                FeatureCard(
                  imagePath: 'assets/images/career2.png',
                  title: 'STEM Careers',
                  onTap: () => widget.onNavigate(6),
                ),
                FeatureCard(
                  imagePath: 'assets/images/dailychallengeicon2.png',
                  title: 'Daily Challenge',
                  onTap: () => widget.onNavigate(7),
                ),
                FeatureCard(
                  imagePath: 'assets/images/faqicon2.png',
                  title: 'FAQ',
                  onTap: () => widget.onNavigate(8),
                ),
              ],
            ),
          ),

          Stack(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'STEM Highlights',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              //map
              // Positioned(top: 0, right: 0, child: GestureDetector()),
            ],
          ),

          SizedBox(height: 4),

          ///STEM HIGHLIGHT CAROUSEL (DATABASE)
          highlights.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : CarouselSlider(
                  items: highlights.map((item) {
                    return GestureDetector(
                      onTap: () => widget.onHighlightTap(item),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(item['media'][0], fit: BoxFit.fill),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 20,
                              child: Text(
                                item['highlight_title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1),
                                      blurRadius: 4,
                                    ),
                                  ],
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
                    viewportFraction: 0.85,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentHighlightIndex = index;
                      });
                    },
                  ),
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
            Image.asset(imagePath, width: 120, height: 120),
            const SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }
}
