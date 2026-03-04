import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stemxplore/bookmarkmanager.dart';
import 'package:stemxplore/ipaddress.dart';
import 'package:video_player/video_player.dart';
import 'package:stemxplore/theme_provider.dart';

class Materialdetailpage extends StatelessWidget {
  final Map learningMaterial;

  const Materialdetailpage({super.key, required this.learningMaterial});

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish =
        (localization.currentLocale?.languageCode ?? 'en') == 'en';

    final String title = isEnglish
        ? (learningMaterial['learning_title_en']?.toString() ?? '')
        : (learningMaterial['learning_title_ms']?.toString() ?? '');
    final theme = Theme.of(context);
    return GradientBackground(
      child: Scaffold(
        appBar: _buildAppBar(context, isEnglish, title),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 100, 8, 20),
          child: Column(
            children: List.generate(learningMaterial['pages'].length, (index) {
              final page = learningMaterial['pages'][index];
              return _PageItem(page: page);
            }),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isEnglish, String title) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                final localization = FlutterLocalization.instance;
                final currentLang =
                    localization.currentLocale?.languageCode ?? 'en';
                final newLang = currentLang == 'en' ? 'ms' : 'en';
                localization.translate(newLang);
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
}

class _PageItem extends StatelessWidget {
  final Map page;
  const _PageItem({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final FlutterLocalization localization = FlutterLocalization.instance;
    final bool isEnglish =
        (localization.currentLocale?.languageCode ?? 'en') == 'en';
    final pageId = page['page_id'];

    // Listen to BookmarkManager for changes
    final bookmarkManager = context.watch<BookmarkManager>();
    final isBookmarked = bookmarkManager.isBookmarked(pageId);

    final description = isEnglish
        ? page['page_desc_en'] ?? ''
        : page['page_desc_ms'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER + BOOKMARK ICON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  isEnglish ? page['page_title_en'] : page['page_title_ms'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.green,
                ),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Bookmark'),
                      content: Text(
                        isBookmarked
                            ? 'Remove bookmark for this page?'
                            : 'Bookmark this page?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await bookmarkManager.toggleBookmark(pageId);

                    // Update database
                    try {
                      await http.post(
                        Uri.parse('${ipaddress.baseUrl}api/bookmark_page.php'),
                        body: {
                          'page_id': pageId,
                          'bookmark': bookmarkManager.isBookmarked(pageId)
                              ? 'yes'
                              : 'no',
                        },
                      );
                    } catch (e) {
                      print('DB update error: $e');
                    }
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// MEDIA
          Column(
            children: (page['media'] ?? []).map<Widget>((media) {
              if (media['type'] == 'image') {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(media['url'], fit: BoxFit.cover),
                  ),
                );
              } else {
                return VideoWidget(url: media['url'], isLarge: false);
              }
            }).toList(),
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            description,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/// Video Widget remains the same as before
class VideoWidget extends StatefulWidget {
  final String url;
  final bool isLarge;
  const VideoWidget({super.key, required this.url, required this.isLarge});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController controller;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        if (!isDisposed && mounted) setState(() {});
      });
    controller.setLooping(false);
    controller.setVolume(1.0);
    controller.addListener(() {
      if (!isDisposed && mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 24, 10, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: widget.isLarge ? 450 : 200,
          color: Colors.grey.shade200,
          child: controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    FittedBox(
                      child: SizedBox(
                        width: controller.value.size.width,
                        height: controller.value.size.height,
                        child: VideoPlayer(controller),
                      ),
                    ),
                    IconButton(
                      iconSize: 30,
                      color: Colors.white,
                      icon: Icon(
                        controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      onPressed: () {
                        setState(() {
                          controller.value.isPlaying
                              ? controller.pause()
                              : controller.play();
                        });
                      },
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
