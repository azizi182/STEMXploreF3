import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/theme_provider.dart';
import 'package:video_player/video_player.dart';

class StemInfoDetailPage extends StatefulWidget {
  final Map stemInfo;

  const StemInfoDetailPage({super.key, required this.stemInfo});

  @override
  State<StemInfoDetailPage> createState() => _StemInfoDetailPageState();
}

class _StemInfoDetailPageState extends State<StemInfoDetailPage> {
  //VoidCallback? get _toggleBookmark => null;

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    final String description = isEnglish
        ? (widget.stemInfo['info_desc_en']?.toString() ?? '')
        : (widget.stemInfo['info_desc_ms']?.toString() ?? '');
    final bool hasDescription = description.trim().isNotEmpty;
    final theme = Theme.of(context);

    return GradientBackground(
      child: Scaffold(
        appBar: buildCustomAppBar(
          isEnglish,
          isEnglish
              ? (widget.stemInfo['info_title_en']?.toString() ?? '')
              : (widget.stemInfo['info_title_ms']?.toString() ?? ''),
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,

        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 100, 8, 20),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// MEDIA (same concept as learning)
                _buildMedia(),

                const SizedBox(height: 10),

                /// DESCRIPTION
                if (description.trim().isNotEmpty)
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.6,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// MEDIA BUILDER
  Widget _buildMedia() {
    final List mediaList = widget.stemInfo['media'] is List
        ? widget.stemInfo['media']
        : [widget.stemInfo['media']];

    if (widget.stemInfo['info_type'] == 'image') {
      return Column(
        children: mediaList.map<Widget>((img) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullScreenImagePage(imageUrl: img),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return VideoWidget(
        url: mediaList.first,
        height: 220, // same style as learning
      );
    }
  }

  AppBar buildCustomAppBar(bool isEnglish, String title) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: App title with F3 badge
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
                maxLines: 1, // ✅ single line
                overflow: TextOverflow.ellipsis,
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

//image

// Video Widget (same as above)
class VideoWidget extends StatefulWidget {
  final String url;
  //final bool isLarge;
  final double height;
  const VideoWidget({
    super.key,
    required this.url,
    //required this.isLarge,
    required this.height,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController controller;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.url)
      ..initialize().then((_) {
        if (!isDisposed && mounted) setState(() {});
      });
    controller.setLooping(false);
    controller.setVolume(1.0);

    // Listen to controller to update progress bar
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
          height: 200,
          color: Colors.grey.shade200,
          child: controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    FittedBox(
                      // fit: BoxFit.fill,
                      child: SizedBox(
                        width: controller.value.size.width,
                        height: controller.value.size.height,
                        child: VideoPlayer(controller),
                      ),
                    ),
                    // Gradient overlay at bottom for controls
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
              child: Image.asset(
                imageUrl,
                fit: BoxFit.contain,

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
