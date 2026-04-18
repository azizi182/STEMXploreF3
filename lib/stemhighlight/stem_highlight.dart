import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/theme_provider.dart';
import 'package:video_player/video_player.dart';

class StemHighlight extends StatefulWidget {
  final Map data;
  const StemHighlight({super.key, required this.data});

  @override
  State<StemHighlight> createState() => _StemHighlightState();
}

class _StemHighlightState extends State<StemHighlight> {
  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    final String description = isEnglish
        ? (widget.data['highlight_desc_en']?.toString() ?? '')
        : (widget.data['highlight_desc_ms']?.toString() ?? '');
    final bool hasDescription = description.trim().isNotEmpty;

    return GradientBackground(
      child: Scaffold(
        appBar: buildCustomAppBar(
          isEnglish,
          isEnglish
              ? (widget.data['highlight_title_en']?.toString() ?? '')
              : (widget.data['highlight_title_ms']?.toString() ?? ''),
        ),
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
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
                /// MEDIA FIRST (like learning page)
                _buildMedia(false),

                const SizedBox(height: 12),

                /// DESCRIPTION
                if (description.trim().isNotEmpty)
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedia(bool hasDescription) {
    final List mediaList = widget.data['media'] is List
        ? widget.data['media']
        : [widget.data['media']];

    if (widget.data['highlight_type'] == 'image') {
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
                child: Image.network(
                  img,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return VideoWidget(url: mediaList.first, height: 220);
    }
  }

  AppBar buildCustomAppBar(bool isEnglish, String title) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
      backgroundColor: Color.fromARGB(255, 52, 137, 55),
    );
  }
}

//image
Widget _imageItem(BuildContext context, String url, double height) {
  return GestureDetector(
    onTap: () {
      // Open full screen image
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FullScreenImagePage(imageUrl: url)),
      );
    },
    child: SizedBox(
      width: double.infinity,
      height: height,

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.broken_image, size: 40));
          },
        ),
      ),
    ),
  );
}

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
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
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
