import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/database/dao/bookmark_dao.dart';
import 'package:stemxplore/learningmaterial/materialdetailpage.dart';
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
      final data = await LearningPageDao.getBookmarkedPages();

      List<Map<String, dynamic>> pages = [];

      for (var row in data) {
        pages.add({
          'learning_subject_en': row['learning_subject_en'],
          'learning_subject_ms': row['learning_subject_ms'],
          'learning_title_en': row['learning_title_en'],
          'learning_title_ms': row['learning_title_ms'],
          'page': {
            'page_id': row['page_id'],
            'page_title_en': row['page_title_en'],
            'page_title_ms': row['page_title_ms'],
            'page_desc_en': row['page_desc_en'],
            'page_desc_ms': row['page_desc_ms'],
            'media': [
              {'type': row['media_type'], 'url': row['media_url']},
            ],
          },
        });
      }

      setState(() {
        bookmarkedPages = pages;
      });
    } catch (e) {
      print("Error loading bookmarks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish = localization.currentLocale?.languageCode == 'en';

    final filteredBookmarks =
        (selectedCategory == "All" || selectedCategory == "Semua")
        ? bookmarkedPages
        : bookmarkedPages.where((m) {
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

                              child: GestureDetector(
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

                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(bottom: 16),
                                  decoration: BoxDecoration(
                                    color:
                                        selectedPages.contains(
                                          page['page_id'].toString(),
                                        )
                                        ? Colors.green.withOpacity(0.08)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                    border:
                                        selectedPages.contains(
                                          page['page_id'].toString(),
                                        )
                                        ? Border.all(
                                            color: Colors.green,
                                            width: 1.5,
                                          )
                                        : null,
                                  ),

                                  child: Row(
                                    children: [
                                      /// 🔥 IMAGE WITH MODERN STYLE
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                              left: Radius.circular(20),
                                            ),
                                        child: Stack(
                                          children: [
                                            page['media'] != null &&
                                                    page['media'].isNotEmpty &&
                                                    page['media'][0]['type'] ==
                                                        'image'
                                                ? Image.asset(
                                                    page['media'][0]['url'],
                                                    width: 110,
                                                    height: 110,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Container(
                                                    width: 110,
                                                    height: 110,
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.image,
                                                    ),
                                                  ),

                                            /// gradient overlay
                                            Container(
                                              width: 110,
                                              height: 110,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.black.withOpacity(
                                                      0.1,
                                                    ),
                                                    Colors.transparent,
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      /// 🔥 CONTENT
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// SUBJECT BADGE
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),

                                                child: Text(
                                                  subject ?? '',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: 10),

                                              /// TITLE
                                              Text(
                                                title ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                              const SizedBox(height: 4),

                                              /// PAGE TITLE
                                            ],
                                          ),
                                        ),
                                      ),

                                      /// 🔥 RIGHT ICON / CHECK
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: AnimatedSwitcher(
                                          duration: const Duration(
                                            milliseconds: 200,
                                          ),
                                          child: selectionMode
                                              ? Icon(
                                                  selectedPages.contains(
                                                        page['page_id']
                                                            .toString(),
                                                      )
                                                      ? Icons.check_circle
                                                      : Icons
                                                            .radio_button_unchecked,
                                                  key: ValueKey(
                                                    selectedPages.contains(
                                                      page['page_id']
                                                          .toString(),
                                                    ),
                                                  ),
                                                  color: Colors.green,
                                                  size: 26,
                                                )
                                              : const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 18,
                                                  color: Colors.grey,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                              for (String id in selectedPages) {
                                await LearningPageDao.updateBookmark(
                                  int.parse(id),
                                  'no',
                                );
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
