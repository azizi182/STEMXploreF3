import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HERO MEDIA
                    _buildMedia(),

                    /// CONTENT CARD
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      constraints: const BoxConstraints(
                        minHeight: 220, // 🔥 FIXED MIN HEIGHT
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TITLE
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.stemInfo['info_title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),

                              IconButton(
                                icon: Icon(Icons.bookmark),
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

            /// BACK BUTTON (Overlay)
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
          height: 220,
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
