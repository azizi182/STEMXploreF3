import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/theme_provider.dart';
import 'package:stemxplore/learningmaterial/materialdetailpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stemxplore/ipaddress.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Learningmaterialpage extends StatefulWidget {
  final Function(dynamic) onSelect;
  const Learningmaterialpage({super.key, required this.onSelect});

  @override
  State<Learningmaterialpage> createState() => _LearningmaterialpageState();
}

class _LearningmaterialpageState extends State<Learningmaterialpage> {
  // Track the selected category
  String selectedCategory = "All";

  List<dynamic> materials = [];
  bool isLoading = true;

  String getSubjectCover({
    required String subjectEn,
    required String subjectMs,
    required bool isEnglish,
  }) {
    if (subjectEn == "Science" || subjectMs == "Sains") {
      return isEnglish
          ? "assets/images/sains_cover_en.jpg"
          : "assets/images/sains_cover.jpg";
    }

    if (subjectEn == "Mathematics" || subjectMs == "Matematik") {
      return isEnglish
          ? "assets/images/math_cover_en.jpg"
          : "assets/images/math_cover.jpg";
    }

    if (subjectEn == "Fundamentals of Computer Science" ||
        subjectMs == "Asas Sains Komputer") {
      return isEnglish
          ? "assets/images/ask_cover_en.jpg"
          : "assets/images/ask_cover.jpg";
    }

    if (subjectEn == "Design And Technology" ||
        subjectMs == "Reka Bentuk Dan Teknologi") {
      return isEnglish
          ? "assets/images/rbt_cover_en.jpg"
          : "assets/images/rbt_cover.jpg";
    }

    return "assets/images/default_cover.jpg";
  }

  @override
  void initState() {
    super.initState();
    fetchLearningMaterials();
  }

  Future<void> fetchLearningMaterials() async {
    try {
      final response = await http.get(
        Uri.parse('${ipaddress.baseUrl}api/get_learning_material.php'),
      );
      print("error learning" + response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract subjects dynamically
        final subjectSet = <String>{};

        for (var item in data) {
          subjectSet.add(item['learning_subject_en']);
        }

        setState(() {
          materials = data;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  bool isVideo(String file) {
    return file.toLowerCase().endsWith('.mp4') ||
        file.toLowerCase().endsWith('.mov') ||
        file.toLowerCase().endsWith('.avi');
  }

  //thumbnail generation for video

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    // Filter the list based on selection
    final filteredMaterials =
        (selectedCategory == "All" || selectedCategory == "Semua")
        ? materials
        : materials.where((m) {
            final subjectEn = m['learning_subject_en'];
            final subjectMs = m['learning_subject_ms'];

            switch (selectedCategory) {
              case "Science":
              case "Sains":
                return subjectEn == "Science" || subjectMs == "Sains";

              case "Mathematics":
              case "Matematik":
                return subjectEn == "Mathematics" || subjectMs == "Matematik";

              case "Fundamentals of Computer Science":
              case "Asas Sains Komputer":
                return subjectEn == "Fundamentals of Computer Science" ||
                    subjectMs == "Asas Sains Komputer";

              case "Design And Technology":
              case "Reka Bentuk Dan Teknologi":
                return subjectEn == "Design And Technology" ||
                    subjectMs == "Reka Bentuk Dan Teknologi";

              default:
                return false;
            }
          }).toList();

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(isEnglish),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildCategoryTabs(isEnglish),
                    const SizedBox(height: 10),
                    Expanded(
                      child: filteredMaterials.isEmpty
                          ? Center(
                              child: Text(
                                isEnglish
                                    ? "No learning material available"
                                    : "Tiada bahan pembelajaran",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              itemCount: filteredMaterials.length,
                              itemBuilder: (context, index) {
                                final item = filteredMaterials[index];

                                return GestureDetector(
                                  onTap: () {
                                    widget.onSelect(item);
                                  },
                                  child: _learningCard(
                                    title: isEnglish
                                        ? item['learning_title_en']
                                        : item['learning_title_ms'],
                                    subject: isEnglish
                                        ? item['learning_subject_en']
                                        : item['learning_subject_ms'],

                                    coverImage: getSubjectCover(
                                      subjectEn: item['learning_subject_en'],
                                      subjectMs: item['learning_subject_ms'],
                                      isEnglish: isEnglish,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _learningCard({
    required String title,
    required String subject,
    required String coverImage,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// TEXT SIDE
          Expanded(
            child: Column(
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
                const SizedBox(height: 4),
                Text(
                  subject,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(width: 15),

          /// IMAGE / VIDEO THUMBNAIL
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              coverImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(bool isEnglish) {
    final List<String> displaySubjects = isEnglish
        ? [
            "All",
            "Science",
            "Mathematics",
            "Fundamentals of Computer Science",
            "Design And Technology",
          ]
        : [
            "Semua",
            "Sains",
            "Matematik",
            "Asas Sains Komputer",
            "Reka Bentuk Dan Teknologi",
          ];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: displaySubjects.length,
        itemBuilder: (context, index) {
          final displayText = displaySubjects[index];
          bool isSelected = selectedCategory == displayText;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = displayText;
              });
            },
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
                displayText,
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

  AppBar buildCustomAppBar(bool isEnglish) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: App title with F3 badge
            Text(
              isEnglish ? "Learning Material" : 'Bahan Pembelajaran',

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),

            // Right Side: Flag toggle (for display only now)
            GestureDetector(
              onTap: () {
                final FlutterLocalization localization =
                    FlutterLocalization.instance;

                final String currentLang =
                    localization.currentLocale?.languageCode ?? 'en';

                final String nextLocale = currentLang == 'en' ? 'ms' : 'en';

                localization.translate(nextLocale);

                setState(() {
                  if (nextLocale == 'ms') {
                    if (selectedCategory == "All") selectedCategory = "Semua";
                    if (selectedCategory == "Science") {
                      selectedCategory = "Sains";
                    }
                    if (selectedCategory == "Mathematics") {
                      selectedCategory = "Matematik";
                    }
                    if (selectedCategory ==
                        "Fundamentals of Computer Science") {
                      selectedCategory = "Asas Sains Komputer";
                    }
                    if (selectedCategory == "Design And Technology") {
                      selectedCategory = "Reka Bentuk Dan Teknologi";
                    }
                  } else {
                    if (selectedCategory == "Semua") selectedCategory = "All";
                    if (selectedCategory == "Sains") {
                      selectedCategory = "Science";
                    }
                    if (selectedCategory == "Matematik") {
                      selectedCategory = "Mathematics";
                    }
                    if (selectedCategory == "Asas Sains Komputer") {
                      selectedCategory = "Fundamentals of Computer Science";
                    }
                    if (selectedCategory == "Reka Bentuk Dan Teknologi") {
                      selectedCategory = "Design And Technology";
                    }
                  }
                }); // rebuild UI
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
                    // The flag changes based on isEnglish
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
      ),
      backgroundColor: Color.fromARGB(255, 52, 137, 55),
    );
  }
}
