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
                  await bookmarkManager.toggleBookmark(pageId);

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

                  if (context.mounted) {
                    final isAdding = bookmarkManager.isBookmarked(pageId);

                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;

                    _showBookmarkPopup(
                      context,
                      isAdding: isAdding,
                      isEnglish: isEnglish,
                      isDark: isDark,
                    );
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImagePage(imageUrl: media['url']),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(media['url'], fit: BoxFit.cover),
                    ),
                  ),
                );
              } else {
                return VideoWidget(url: media['url'], isLarge: false);
              }
            }).toList(),
          ),

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

void _showBookmarkPopup(
  BuildContext context, {
  required bool isAdding,
  required bool isEnglish,
  required bool isDark,
}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF3D3D3D) : Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isAdding ? Icons.bookmark_added : Icons.bookmark_remove,
                size: 55,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(height: 16),

              Text(
                isAdding
                    ? (isEnglish
                          ? "Bookmarked successfully"
                          : "Berjaya ditanda buku")
                    : (isEnglish ? "Bookmark removed" : "Penanda buku dibuang"),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
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

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              maxScale: 5.0, // allow pinch zoom
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stack) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              iconSize: 35,
              color: Colors.white,
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
