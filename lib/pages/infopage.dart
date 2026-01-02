import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stemxplore/ipaddress.dart';
import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';

class Infopage extends StatefulWidget {
  const Infopage({super.key});

  @override
  State<Infopage> createState() => _InfopageState();
}

class _InfopageState extends State<Infopage> {
  List<Map<String, dynamic>> infos = [];
  List<bool> expanded = [];
  bool isLoading = true;

  void initState() {
    super.initState();
    fetchInfo();
  }

  Future<void> fetchInfo() async {
    try {
      final response = await http.get(
        Uri.parse('${ipaddress.baseUrl}api/get_app_info.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          infos = data.map((e) => e as Map<String, dynamic>).toList();
          expanded = List.filled(infos.length, false);
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Info'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                itemCount: infos.length,
                itemBuilder: (context, index) {
                  final info = infos[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            expanded[index] = !expanded[index];
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          margin: EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 252, 252, 252),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  info['app_question']!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              //animation arrow
                              AnimatedRotation(
                                turns: expanded[index] ? 0.5 : 0,
                                duration: const Duration(milliseconds: 300),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF93DA97),
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            info['app_answer']!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        crossFadeState: expanded[index]
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
