import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stemxplore/bookmarkmanager.dart';
import 'package:stemxplore/ipaddress.dart';
import 'package:stemxplore/learningmaterial/materialdetailpage.dart';
import 'package:stemxplore/theme_provider.dart';
import 'package:stemxplore/theme_provider.dart';

class Bookmarkpage extends StatefulWidget {
  const Bookmarkpage({super.key});

  @override
  State<Bookmarkpage> createState() => _BookmarkpageState();
}

class _BookmarkpageState extends State<Bookmarkpage> {
  List<Map<String, dynamic>> bookmarkedPages = [];
  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final manager = await BookmarkManager.getInstance();
    final pageIds = manager.getBookmarks();

    // You need your API data (materials) to find these pages
    final response = await http.get(
      Uri.parse('${ipaddress.baseUrl}api/get_learning_material.php'),
    );
    final data = (json.decode(response.body) as List<dynamic>);

    List<Map<String, dynamic>> pages = [];
    for (var learning in data) {
      for (var page in (learning['pages'] ?? [])) {
        if (pageIds.contains(page['page_id'])) {
          pages.add({
            'learning_subject_en': learning['learning_subject_en'],
            'learning_subject_ms': learning['learning_subject_ms'],
            'learning_title_en': learning['learning_title_en'],
            'learning_title_ms': learning['learning_title_ms'],
            'page': page,
          });
        }
      }
    }

    setState(() {
      bookmarkedPages = pages;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';
    final theme = Theme.of(context);

    final filteredBookmarks =
        (selectedCategory == "All" || selectedCategory == "Semua")
        ? bookmarkedPages
        : bookmarkedPages.where((item) {
            final subjectEn = item['learning_subject_en'];
            final subjectMs = item['learning_subject_ms'];

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
        appBar: buildCustomAppBar(isEnglish, 'Bookmarks'),
        backgroundColor: Colors.transparent,

        body: RefreshIndicator(
          onRefresh: _loadBookmarks,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),

                _buildCategoryTabs(isEnglish),

                const SizedBox(height: 10),

                Expanded(
                  child: filteredBookmarks.isEmpty
                      ? ListView(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Center(
                              child: Text(
                                isEnglish
                                    ? "No bookmarks available"
                                    : "Tiada bookmark",
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: filteredBookmarks.length,
                          itemBuilder: (context, index) {
                            final item = filteredBookmarks[index];

                            final page = item['page'];
                            final title = isEnglish
                                ? item['learning_title_en']
                                : item['learning_title_ms'];
                            final pageTitle = isEnglish
                                ? page['page_title_en']
                                : page['page_title_ms'];
                            final subject = isEnglish
                                ? item['learning_subject_en']
                                : item['learning_subject_ms'];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Materialdetailpage(
                                      learningMaterial: {
                                        'learning_title_en':
                                            item['learning_title_en'],
                                        'learning_title_ms':
                                            item['learning_title_ms'],
                                        'pages': [item['page']],
                                      },
                                    ),
                                  ),
                                ).then((_) => _loadBookmarks());
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    /// LEFT IMAGE
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:
                                          page['media'] != null &&
                                              page['media'].isNotEmpty &&
                                              page['media'][0]['type'] ==
                                                  'image'
                                          ? Image.network(
                                              page['media'][0]['url'],
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              width: 90,
                                              height: 90,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.image,
                                                size: 40,
                                              ),
                                            ),
                                    ),

                                    const SizedBox(width: 15),

                                    /// RIGHT CONTENT
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            subject,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          /// Learning Title
                                          Text(
                                            title,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          const SizedBox(height: 6),

                                          /// Page Title
                                          Text(
                                            pageTitle,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// Arrow
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                  ],
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
      ),
    );
  }

  AppBar buildCustomAppBar(bool isEnglish, String s) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isEnglish ? "Bookmarks" : "Penanda Halaman",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),

            // Right Side: Flag toggle (for display only now)
            GestureDetector(
              onTap: () {
                final localization = FlutterLocalization.instance;

                // Toggle language
                final currentLang =
                    localization.currentLocale?.languageCode ?? 'en';
                final newLang = currentLang == 'en' ? 'ms' : 'en';

                localization.translate(newLang);

                setState(() {}); // rebuild UI
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
      backgroundColor: theme.brightness == Brightness.dark
          ? Color.fromRGBO(179, 204, 161, 1)
          : Color.fromARGB(255, 52, 137, 55),
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
                    : Colors.white.withOpacity(0.4),
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
}
