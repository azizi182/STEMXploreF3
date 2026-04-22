import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/database/dao/info_dao.dart';
import 'package:stemxplore/theme_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
      final data = await StemInfoDao.getAllInfo();

      setState(() {
        stemInfoList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("DB Error: $e");
    }
  }

  bool isVideo(String file) {
    return file.toLowerCase().endsWith('.mp4') ||
        file.toLowerCase().endsWith('.mov') ||
        file.toLowerCase().endsWith('.avi');
  }

  //thumbnail generation for video
  Future<Uint8List?> _generateVideoThumbnail(String videoUrl) async {
    try {
      return await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 260,
        quality: 75,
      );
    } catch (e) {
      print("Thumbnail error: $e");
      return null;
    }
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
            : SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: stemInfoList.length,
                        itemBuilder: (context, index) {
                          final item = stemInfoList[index];
                          final List mediaList = item['media'];
                          final String fileUrl = mediaList.isNotEmpty
                              ? mediaList[0]
                              : '';

                          if (fileUrl.isEmpty) {
                            return Container(
                              height: 115,
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.broken_image),
                              ),
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              widget.onSelect(item);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.35),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// TITLE ROW
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          isEnglish
                                              ? item['info_title_en']
                                              : item['info_title_ms'],
                                          style: const TextStyle(
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        isEnglish ? 'Read more' : 'Baca lagi',
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  /// MEDIA PREVIEW (SAME LOGIC AS YOUR OLD CODE)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: double.infinity,
                                      height: 115,
                                      color: Colors.grey.shade200,
                                      child: item['info_type'] == 'video'
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                FutureBuilder<Uint8List?>(
                                                  future:
                                                      _generateVideoThumbnail(
                                                        fileUrl,
                                                      ),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Container(
                                                        color: Colors.black12,
                                                      );
                                                    }

                                                    return Image.memory(
                                                      snapshot.data!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: 115,
                                                    );
                                                  },
                                                ),
                                                const Icon(
                                                  Icons.play_circle_fill,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                              ],
                                            )
                                          : Image.asset(
                                              fileUrl,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              height: 115,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Container(
                                                      color: Colors.grey[300],
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons
                                                              .image_not_supported,
                                                        ),
                                                      ),
                                                    );
                                                  },
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
                  ],
                ),
              ),
      ),
    );
  }

  AppBar buildCustomAppBar(bool isEnglish) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: App title with F3 badge
            Text(
              isEnglish ? "STEM Info" : 'Info STEM',

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: theme.brightness == Brightness.dark
                    ? Colors.black
                    : Colors.black,
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
}
