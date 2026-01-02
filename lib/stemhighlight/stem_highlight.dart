import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:video_player/video_player.dart';

class StemHighlight extends StatelessWidget {
  final Map data;
  const StemHighlight({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
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
                          Text(
                            data['highlight_title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),

                          /// DESCRIPTION
                          Text(
                            data['highlight_desc'],
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

  Widget _buildMedia() {
    if (data['highlight_type'] == 'image') {
      return CarouselSlider(
        options: CarouselOptions(
          height: 300,
          viewportFraction: 1,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlay: true,
          enableInfiniteScroll: false,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        items: data['media'].map<Widget>((img) => _imageItem(img)).toList(),
      );
    } else {
      return VideoWidget(url: data['media'][0]);
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

class VideoWidget extends StatefulWidget {
  final String url;
  const VideoWidget({super.key, required this.url});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.black,
      child: controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
                IconButton(
                  iconSize: 56,
                  color: Colors.white,
                  icon: Icon(
                    controller.value.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
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
    );
  }
}
