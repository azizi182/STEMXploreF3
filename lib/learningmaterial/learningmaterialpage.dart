import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:stemxplore/learningmaterial/materialdetailpage.dart';

class Learningmaterialpage extends StatefulWidget {
  const Learningmaterialpage({super.key});

  @override
  State<Learningmaterialpage> createState() => _LearningmaterialpageState();
}

class _LearningmaterialpageState extends State<Learningmaterialpage> {
  // Track the selected category
  String selectedCategory = "All";

  // Materials data
  final List<Map<String, String>> materials = [
    {
      "title": "Science Form 3",
      "subtitle": "Chapter 3",
      "category": "Science",
      "image": 'assets/images/sains_cover.jpg',
    },
    {
      "title": "Mathematics Form 3",
      "subtitle": "Chapter 1",
      "category": "Mathematics",
      "image": 'assets/images/mt_cover.jpg',
    },
    {
      "title": "Asas Sains Komputer Form 3",
      "subtitle": "Chapter 1",
      "category": "Asas Sains Komputer",
      "image": 'assets/images/ask_cover.jpg',
    },
    {
      "title": "Reka Bentuk Dan Teknologi Form 3",
      "subtitle": "Chapter 1",
      "category": "Reka Bentuk Dan Teknologi",
      "image": 'assets/images/rbt_cover.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter the list based on selection
    final filteredMaterials = selectedCategory == "All"
        ? materials
        : materials.where((m) => m['category'] == selectedCategory).toList();

    return GradientBackground(
      child: Scaffold(
        body: Column(
          children: [
            AppBar(
              title: const Text(
                'Learning Material',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Favorite",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Example favorite card
                    _buildMaterialCard(
                      context,
                      title: "Science Form 3",
                      subtitle: "Chapter 3",
                      imagePath: 'assets/images/sains_cover.jpg',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Materialdetailpage(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),
                    _buildCategoryTabs(),
                    const SizedBox(height: 15),

                    // Dynamic list of filtered cards
                    ...filteredMaterials.map((item) {
                      return _buildMaterialCard(
                        context,
                        title: item['title']!,
                        subtitle: item['subtitle']!,
                        imagePath: item['image']!,
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    List<String> categories = [
      "All",
      "Science",
      "Mathematics",
      "Asas Sains Komputer",
      "Reka Bentuk Dan Teknologi",
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map((cat) => _tabItem(cat, selectedCategory == cat))
            .toList(),
      ),
    );
  }

  Widget _tabItem(String label, bool active) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: active ? Colors.black : Colors.black12,
            width: active ? 1.5 : 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: active ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }

  // _buildMaterialCard method
  Widget _buildMaterialCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String imagePath,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Container(
              width: 85,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
