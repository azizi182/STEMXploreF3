import 'package:carousel_slider/carousel_slider.dart';
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
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(147, 218, 151, 1),
                  ),
                  child: Column(
                    children: [
                      /// MEDIA CARD (height changes if no description)
                      _buildMedia(hasDescription),

                      /// SHOW DESCRIPTION ONLY IF EXISTS
                      if (hasDescription)
                        Container(
                          margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          constraints: const BoxConstraints(minHeight: 220),
                          child: Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.7,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// MEDIA BUILDER
  Widget _buildMedia(bool hasDescription) {
    final theme = Theme.of(context);
    final List mediaList = widget.stemInfo['media'] is List
        ? widget.stemInfo['media']
        : [widget.stemInfo['media']];
    final double mediaHeight = hasDescription
        ? 300
        : MediaQuery.of(context).size.height * 0.7;

    if (widget.stemInfo['info_type'] == 'image') {
      return CarouselSlider(
        options: CarouselOptions(
          height: mediaHeight,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayCurve: Curves.easeInOut,
          enableInfiniteScroll: false,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        items: mediaList.map<Widget>((img) {
          return _imageItem(context, img, mediaHeight);
        }).toList(),
      );
    } else {
      return VideoWidget(url: mediaList.first, height: mediaHeight);
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
