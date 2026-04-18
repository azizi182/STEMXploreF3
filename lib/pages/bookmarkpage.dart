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

  bool selectionMode = false;
  Set<String> selectedPages = {};

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    try {
      final manager = await BookmarkManager.getInstance();
      final pageIds = manager.getBookmarks();

      final response = await http.get(
        Uri.parse('${ipaddress.baseUrl}api/get_learning_material.php'),
      );

      // 1. Check if the server returned a 200 OK
      if (response.statusCode == 200) {
        // 2. Check if the body is actually empty
        if (response.body.isEmpty) {
          print("Error: Server returned an empty body.");
          return;
        }

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
      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Caught error: $e");
      // This will now catch the FormatException instead of crashing the app
    }
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
                Divider(color: Colors.black26),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectionMode
                            ? (isEnglish ? "Select Items" : "Pilih Item")
                            : "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectionMode = !selectionMode;
                            selectedPages.clear();
                          });
                        },
                        child: Text(
                          selectionMode
                              ? (isEnglish ? "Cancel" : "Batal")
                              : (isEnglish ? "Select" : "Pilih"),
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 6, 0),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black26),

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
                                final id = page['page_id'].toString();

                                if (selectionMode) {
                                  setState(() {
                                    if (selectedPages.contains(id)) {
                                      selectedPages.remove(id);
                                    } else {
                                      selectedPages.add(id);
                                    }
                                  });
                                  return;
                                }

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
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          selectedPages.contains(
                                            page['page_id']?.toString() ?? '',
                                          )
                                          ? Border.all(
                                              color: Colors.green,
                                              width: 2,
                                            )
                                          : null,
                                    ),
                                    child: Row(
                                      children: [
                                        /// IMAGE
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
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
                                                  ),
                                                ),
                                        ),

                                        const SizedBox(width: 15),

                                        /// TEXT
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(subject),
                                              Text(title),
                                              Text(pageTitle),
                                            ],
                                          ),
                                        ),

                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// CHECKBOX OVERLAY
                                  if (selectionMode)
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.green,
                                          ),
                                        ),
                                        child: Icon(
                                          selectedPages.contains(
                                                page['page_id']?.toString() ??
                                                    '',
                                              )
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                ),

                if (selectionMode)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton.icon(
                      onPressed: selectedPages.isEmpty
                          ? null
                          : () async {
                              final manager =
                                  await BookmarkManager.getInstance();

                              for (String id in selectedPages) {
                                manager.removeBookmark(id);
                              }

                              selectedPages.clear();
                              selectionMode = false;

                              setState(() {});
                              _loadBookmarks();
                            },
                      icon: const Icon(Icons.delete),
                      label: Text(
                        isEnglish ? "Remove Selected" : "Buang Yang Dipilih",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 45),
                      ),
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
              child: Column(
                children: [
                  ClipOval(
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
                  Text(
                    isEnglish ? 'MS' : 'EN',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
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
