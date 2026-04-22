import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter/material.dart';
import 'package:stemxplore/database/dao/faq_dao.dart';
import 'package:stemxplore/theme_provider.dart';

class Faqpage extends StatefulWidget {
  const Faqpage({super.key});

  @override
  State<Faqpage> createState() => _FaqpageState();
}

class _FaqpageState extends State<Faqpage> {
  List<Map<String, dynamic>> faqs = [];
  List<bool> expanded = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFaq();
  }

  // Function to get data faq from the API
  Future<void> fetchFaq() async {
    try {
      final data = await FaqDao.getFaqs();

      setState(() {
        faqs = data;
        expanded = List.filled(faqs.length, false);
        isLoading = false;
      });
    } catch (e) {
      print("FAQ DB error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(isEnglish),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  final faq = faqs[index];
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
                                  isEnglish
                                      ? faq['faq_question_en']!
                                      : faq['faq_question_ms']!,

                                  style: const TextStyle(
                                    color: Colors.black,
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
                            isEnglish
                                ? faq['faq_answer_en']!
                                : faq['faq_answer_ms']!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        crossFadeState: expanded[index]
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                      const SizedBox(height: 8),

                      // image faq
                      if (expanded[index] && faq['faq_image'] != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(
                            faq['faq_image']!,
                            fit: BoxFit.contain,
                          ),
                        ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  AppBar buildCustomAppBar(bool isEnglish) {
    final theme = Theme.of(context);
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "FAQ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
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
      backgroundColor: theme.brightness == Brightness.dark
          ? Color.fromRGBO(179, 204, 161, 1)
          : Color.fromARGB(255, 52, 137, 55),
    );
  }
}
