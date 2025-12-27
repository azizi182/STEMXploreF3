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
        appBar: AppBar(title: Text(data['highlight_title'])),
        body: SingleChildScrollView(
          child: Column(
            children: [
              data['highlight_type'] == 'image'
                  ? CarouselSlider(
                      options: CarouselOptions(height: 250),
                      items: data['media'].map<Widget>((img) {
                        return Image.network(img, fit: BoxFit.cover);
                      }).toList(),
                    )
                  : VideoWidget(url: data['media'][0]),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  data['highlight_desc'],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
        controller.play();
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          )
        : const Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          );
  }
}
