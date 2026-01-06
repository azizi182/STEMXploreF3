import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:stemxplore/ipaddress.dart';
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
    return GradientBackground(
      child: Scaffold(
        appBar: buildCustomAppBar(isEnglish, widget.stemInfo['info_title']),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(147, 218, 151, 1),
                  ),
                  child: Column(
                    children: [
                      /// MEDIA CARD
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        decoration: BoxDecoration(
                          color: Colors.white, // card color for media
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _buildMedia(),
                      ),

                      /// TITLE + DESCRIPTION CARD
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                        decoration: BoxDecoration(
                          color: Colors.white, // card background
                          borderRadius: BorderRadius.circular(20),
                        ),
                        constraints: const BoxConstraints(minHeight: 220),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// TITLE + BOOKMARK
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.stemInfo['info_title'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.bookmark),
                                  onPressed: () {},
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            /// DESCRIPTION
                            Text(
                              widget.stemInfo['info_desc'],
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.7,
                                color: Colors.black87,
                              ),
                            ),
                          ],
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
  Widget _buildMedia() {
    final List mediaList = widget.stemInfo['media'] is List
        ? widget.stemInfo['media']
        : [widget.stemInfo['media']];

    if (widget.stemInfo['info_type'] == 'image') {
      return CarouselSlider(
        options: CarouselOptions(
          height: 300,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: false,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        items: mediaList.map<Widget>((img) => _imageItem(img)).toList(),
      );
    } else {
      return VideoWidget(url: mediaList.first);
    }
  }
}

//image
Widget _imageItem(String url) {
  return Container(
    padding: EdgeInsets.fromLTRB(10, 24, 10, 20),

    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 260,
        color: Colors.grey.shade200, // fallback background
        child: Image.network(
          url,
          fit: BoxFit.fill,
          alignment: Alignment.center,
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
  const VideoWidget({super.key, required this.url});

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
                      fit: BoxFit.cover,
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

AppBar buildCustomAppBar(bool isEnglish, String title) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: App title with F3 badge
          const SizedBox(width: 50),
          Text(
            title,
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
