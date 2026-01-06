import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stemxplore/gradient_background.dart';

class Challenge {
  final String titleEn;
  final String titleMs;
  final String factEn;
  final String factMs;
  final String imagePath;

  Challenge({
    required this.titleEn,
    required this.titleMs,
    required this.factEn,
    required this.factMs,
    required this.imagePath,
  });
}

class Dailychallengepage extends StatefulWidget {
  const Dailychallengepage({super.key});

  @override
  State<Dailychallengepage> createState() => _DailychallengepageState();
}

class _DailychallengepageState extends State<Dailychallengepage> {
  final String title = 'Daily Challenge';
  bool _isCompleted = false;
  bool _isLoading = true;

  final List<Challenge> _challenges = [
    Challenge(
      titleEn: 'Renewable Energy',
      titleMs: 'Tenaga Boleh Diperbaharui',
      factEn:
          'Renewable energy sources like solar and wind can provide electricity without harming the environment.',
      factMs:
          'Sumber tenaga boleh diperbaharui seperti solar dan angin boleh menghasilkan elektrik tanpa merosakkan alam sekitar.',
      imagePath: 'assets/images/renewable_energy.jpg',
    ),

    Challenge(
      titleEn: 'Recycling',
      titleMs: 'Kitar Semula',
      factEn:
          'Recycling reduces waste, conserves natural resources, and helps protect the environment.',
      factMs:
          'Kitar semula mengurangkan sisa, mengekalkan sumber semula jadi, dan membantu melindungi alam sekitar.',
      imagePath: 'assets/images/recycling.jpg',
    ),

    Challenge(
      titleEn: 'Human Digestive System',
      titleMs: 'Sistem Pencernaan Manusia',
      factEn:
          'The digestive system breaks down food into nutrients that our body can use for energy, growth, and repair.',
      factMs:
          'Sistem pencernaan memecahkan makanan menjadi nutrien yang boleh digunakan oleh tubuh untuk tenaga, pertumbuhan, dan pembaikan.',
      imagePath: 'assets/images/digestive_system.jpg',
    ),

    Challenge(
      titleEn: 'Water Cycle',
      titleMs: 'Kitaran Air',
      factEn:
          'The water cycle circulates water through evaporation, condensation, and precipitation, supporting life on Earth.',
      factMs:
          'Kitaran air mengedarkan air melalui penyejatan, pemeluwapan, dan pemendakan, menyokong kehidupan di Bumi.',
      imagePath: 'assets/images/water_cycle.jpg',
    ),

    Challenge(
      titleEn: 'Photosynthesis',
      titleMs: 'Fotosintesis',
      factEn:
          'Photosynthesis is the process by which plants make food using sunlight, carbon dioxide, and water, producing oxygen for us to breathe.',
      factMs:
          'Fotosintesis ialah proses di mana tumbuhan menghasilkan makanan menggunakan cahaya matahari, karbon dioksida dan air, serta menghasilkan oksigen untuk kita bernafas.',
      imagePath: 'assets/images/photosynthesis.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkTodayStatus();
  }

  String _getTodayKey() {
    final now = DateTime.now();
    return "challenge_${now.year}_${now.month}_${now.day}";
  }

  Future<void> _checkTodayStatus() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _isCompleted = prefs.getBool(_getTodayKey()) ?? false;
      _isLoading = false;
    });
  }

  Future<void> _handleComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getTodayKey(), true);
    if (!mounted) return;
    setState(() {
      _isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlutterLocalization localization = FlutterLocalization.instance;
    final String currentLang = localization.currentLocale?.languageCode ?? 'en';
    final bool isEnglish = currentLang == 'en';

    final int dayIndex = DateTime.now().day % _challenges.length;
    final currentChallenge = _challenges[dayIndex];
    final String title = isEnglish ? 'Daily Challenge' : 'Cabaran Harian';
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildCustomAppBar(isEnglish, title, localization),
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 35,
                              ), // MOVED SLIGHTLY BELOW
                              // CHALLENGE CARD
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: Colors.black12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.35,
                                      ),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      isEnglish
                                          ? 'STEM Fact of the Day – ${currentChallenge.titleEn}'
                                          : 'Fakta STEM Hari Ini – ${currentChallenge.titleMs}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        currentChallenge.imagePath,
                                        height: 160,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        isEnglish
                                            ? 'Did you know?'
                                            : 'Tahukah anda?',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      isEnglish
                                          ? currentChallenge.factEn
                                          : currentChallenge.factMs,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    ElevatedButton(
                                      onPressed: _isCompleted
                                          ? null
                                          : _handleComplete,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(
                                          double.infinity,
                                          50,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        _isCompleted
                                            ? (isEnglish
                                                  ? 'Challenge Finished'
                                                  : 'Cabaran Selesai')
                                            : (isEnglish
                                                  ? 'Complete Challenge'
                                                  : 'Selesaikan Cabaran'),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 45),

                              // SUCCESS MESSAGE (SMALLER CARD + STRONGER SHADOW)
                              if (_isCompleted)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                  ), // Makes card smaller
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.35,
                                          ), // STRONGER SHADOW
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color.fromARGB(
                                            255,
                                            93,
                                            241,
                                            98,
                                          ),
                                          size: 40,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          isEnglish ? 'Well done!' : 'Syabas!',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          isEnglish
                                              ? 'You completed today\'s challenge.'
                                              : 'Anda telah menyelesaikan cabaran hari ini.',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildCustomAppBar(
    bool isEnglish,
    String title,
    FlutterLocalization localization,
  ) {
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
              onTap: () async {
                final localization = FlutterLocalization.instance;

                // Toggle language
                final currentLang =
                    localization.currentLocale?.languageCode ?? 'en';
                final newLang = currentLang == 'en' ? 'ms' : 'en';

                localization.translate(newLang);

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
      backgroundColor: Color.fromARGB(255, 52, 137, 55),
    );
  }
}
