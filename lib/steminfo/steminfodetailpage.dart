import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:stemxplore/ipaddress.dart';
import 'package:video_player/video_player.dart';

class StemInfoDetailPage extends StatelessWidget {
  final dynamic stemInfo;

  const StemInfoDetailPage({super.key, required this.stemInfo});

  @override
  Widget build(BuildContext context) {
    final fileUrl = stemInfo['media'];

    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          title: Text(stemInfo['info_title']),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        //body
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //media
              stemInfo['info_type'] == 'video'
                  ? VideoWidget(url: fileUrl)
                  : Image.network(
                      fileUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 16),
              //title
              Text(
                stemInfo['info_title'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              //description
              Text(
                stemInfo['info_desc'] ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Video Widget (same as above)
class VideoWidget extends StatefulWidget {
  final String url;
  const VideoWidget({super.key, required this.url});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
          initialized = true;
        });
      });
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return initialized
        ? SizedBox(
            height: 250,
            width: double.infinity,
            child: VideoPlayer(_controller),
          )
        : Container(
            height: 250,
            color: Colors.grey[300],
            child: const Center(child: CircularProgressIndicator()),
          );
  }
}
