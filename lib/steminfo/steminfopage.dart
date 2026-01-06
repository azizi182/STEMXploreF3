import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:http/http.dart' as http;
import 'package:stemxplore/ipaddress.dart';
import 'package:stemxplore/steminfo/steminfodetailpage.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart';

class Steminfopage extends StatefulWidget {
  final Function(dynamic) onSelect;
  const Steminfopage({super.key, required this.onSelect});

  @override
  State<Steminfopage> createState() => _SteminfopageState();
}

class _SteminfopageState extends State<Steminfopage> {
  List stemInfoList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStemInfo();
  }

  Future<void> fetchStemInfo() async {
    try {
      final response = await http.get(
        Uri.parse('${ipaddress.baseUrl}api/get_stem_info.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          stemInfoList = data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load STEM info');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  bool isVideo(String file) {
    return file.toLowerCase().endsWith('.mp4') ||
        file.toLowerCase().endsWith('.mov') ||
        file.toLowerCase().endsWith('.avi');
  }

  String _getTranslatedText(String key, bool isEnglish) {
    final Map<String, Map<String, String>> localizedValues = {
      'stem_info': {'en': 'STEM Info', 'ms': 'Info STEM'},
      // Add more key-value pairs as needed
    };
    return localizedValues[key]?[isEnglish ? 'en' : 'ms'] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// APP BAR
        appBar: buildCustomAppBar(isEnglish),
        //content
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: stemInfoList.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = stemInfoList[index];
                  final List mediaList = item['media'];
                  final String fileUrl = mediaList.isNotEmpty
                      ? mediaList[0]
                      : '';

                  return GestureDetector(
                    onTap: () {
                      widget.onSelect(item);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 24, 10, 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: double.infinity,
                                height: 260,
                                color: Colors.grey.shade200,
                                child: item['info_type'] == 'video'
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.network(
                                            fileUrl.replaceAll(
                                              '.mp4',
                                              '.jpg',
                                            ), // optional thumbnail
                                            width: double.infinity,
                                            height: 260,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.black12,
                                                    width: double.infinity,
                                                    height: 260,
                                                  );
                                                },
                                          ),
                                          const Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 64,
                                          ),
                                        ],
                                      )
                                    : Image.network(
                                        fileUrl,
                                        width: double.infinity,
                                        height: 260,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                height: 260,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                  ),
                                                ),
                                              );
                                            },
                                      ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              item['info_title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
            const SizedBox(width: 50),
            Text(
              "STEM Info",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),

            // Right Side: Flag toggle (for display only now)
            GestureDetector(
              onTap: () {
                // TODO: Implement language translation here
                // Example: toggle isEnglish variable and call your translator later
                // setState(() { isEnglish = !isEnglish; });
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
