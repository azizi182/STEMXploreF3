import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:http/http.dart' as http;
import 'package:stemxplore/ipaddress.dart';
import 'package:stemxplore/steminfo/steminfodetailpage.dart';
import 'dart:convert';
import 'package:video_player/video_player.dart';

class Steminfopage extends StatefulWidget {
  final Function(dynamic) onSelect;
  const Steminfopage({super.key, required this.onSelect});

  @override
  State<Steminfopage> createState() => _SteminfopageState();
}

class _SteminfopageState extends State<Steminfopage> {
  List stemInfoList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStemInfo();
  }

  Future<void> fetchStemInfo() async {
    try {
      final response = await http.get(
        Uri.parse('${ipaddress.baseUrl}api/get_stem_info.php'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          stemInfoList = data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load STEM info');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  bool isVideo(String file) {
    return file.toLowerCase().endsWith('.mp4') ||
        file.toLowerCase().endsWith('.mov') ||
        file.toLowerCase().endsWith('.avi');
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('STEM info'),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: stemInfoList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = stemInfoList[index];
                  final List mediaList = item['media'];
                  final String fileUrl = mediaList.isNotEmpty
                      ? mediaList[0]
                      : '';

                  return GestureDetector(
                    onTap: () {
                      widget.onSelect(item);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 24, 10, 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: double.infinity,
                                height: 260,
                                color: Colors.grey.shade200,
                                child: item['info_type'] == 'video'
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.network(
                                            fileUrl.replaceAll(
                                              '.mp4',
                                              '.jpg',
                                            ), // optional thumbnail
                                            width: double.infinity,
                                            height: 260,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.black12,
                                                    width: double.infinity,
                                                    height: 260,
                                                  );
                                                },
                                          ),
                                          const Icon(
                                            Icons.play_circle_fill,
                                            color: Colors.white,
                                            size: 64,
                                          ),
                                        ],
                                      )
                                    : Image.network(
                                        fileUrl,
                                        width: double.infinity,
                                        height: 260,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                height: 260,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                  ),
                                                ),
                                              );
                                            },
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              item['info_title'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
