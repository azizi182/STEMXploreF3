import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:http/http.dart' as http;
import 'package:stemxplore/ipaddress.dart';
import 'package:stemxplore/theme_provider.dart';

class Careerresult extends StatefulWidget {
  final int fieldId;

  const Careerresult({super.key, required this.fieldId});

  @override
  State<Careerresult> createState() => _CareerresultState();
}

class _CareerresultState extends State<Careerresult> {
  List jobs = [];
  bool isLoading = true;

  Future<void> fetchJobs() async {
    final response = await http.get(
      Uri.parse(
        "${ipaddress.baseUrl}api/get_career_job.php?field_id=${widget.fieldId}",
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        jobs = data;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  String getFieldName(bool isEnglish) {
    switch (widget.fieldId) {
      case 1:
        return isEnglish ? "Science" : "Sains";
      case 2:
        return isEnglish ? "Technology" : "Teknologi";
      case 3:
        return isEnglish ? "Engineering" : "Kejuruteraan";
      case 4:
        return isEnglish ? "Mathematics" : "Matematik";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';
    final theme = Theme.of(context);

    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        appBar: buildCustomAppBar(isEnglish, context),

        body: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              /// RESULT HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 60,
                      color: Color.fromARGB(255, 0, 255, 76),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      isEnglish ? "Your STEM Field" : "Bidang STEM Anda",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      getFieldName(isEnglish),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// CAREER LIST
              Expanded(
                child: ListView.builder(
                  itemCount: jobs.length,

                  itemBuilder: (context, index) {
                    var job = jobs[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: Row(
                        children: [
                          /// IMAGE
                          if (job['image'] != null && job['image'].isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),

                              child: Image.network(
                                job['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),

                          const SizedBox(width: 15),

                          /// TEXT
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  isEnglish
                                      ? job['job_title_en']
                                      : job['job_title_ms'],

                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  isEnglish ? job['desc_en'] : job['desc_ms'],

                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildCustomAppBar(bool isEnglish, BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Text(
          isEnglish ? "Career Result" : 'Hasil Karier',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: theme.brightness == Brightness.dark
                ? Colors.black
                : Colors.black,
          ),
        ),
      ),
      backgroundColor: theme.brightness == Brightness.dark
          ? Color.fromRGBO(179, 204, 161, 1)
          : Color.fromARGB(255, 52, 137, 55),
      actions: [
        GestureDetector(
          onTap: () {
            final FlutterLocalization localization =
                FlutterLocalization.instance;
            final String currentLang =
                localization.currentLocale?.languageCode ?? 'en';
            final String nextLocale = currentLang == 'en' ? 'ms' : 'en';
            localization.translate(nextLocale);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ClipOval(
              child: Image.asset(
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
    );
  }
}
