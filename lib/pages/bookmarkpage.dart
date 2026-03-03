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

    return GradientBackground(
      child: Scaffold(
        appBar: buildCustomAppBar(isEnglish, 'Bookmarks'),
        backgroundColor: Colors.transparent,
        body: bookmarkedPages.isEmpty
            ? Center(
                child: Text(isEnglish ? 'No bookmarks yet' : 'Tiada bookmark'),
              )
            : RefreshIndicator(
                onRefresh: _loadBookmarks, // <-- called when pulled
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bookmarkedPages.length,
                  itemBuilder: (context, index) {
                    final item = bookmarkedPages[index];
                    final page = item['page'];
                    final title = isEnglish
                        ? item['learning_title_en']
                        : item['learning_title_ms'];
                    final pageTitle = isEnglish
                        ? page['page_title_en']
                        : page['page_title_ms'];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text('$title - $pageTitle'),
                        trailing: const Icon(Icons.arrow_forward),
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
                                  'pages': [
                                    item['page'],
                                  ], // wrap page in a list
                                },
                              ),
                            ),
                          ).then(
                            (_) => _loadBookmarks(),
                          ); // refresh after return
                        },
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  AppBar buildCustomAppBar(bool isEnglish, String s) {
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
      backgroundColor: Color.fromARGB(255, 52, 137, 55),
    );
  }
}
