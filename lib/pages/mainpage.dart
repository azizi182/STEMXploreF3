import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:stemxplore/pages/bookmarkpage.dart';
import 'package:stemxplore/pages/homepage.dart';
import 'package:stemxplore/pages/infopage.dart';
import 'package:stemxplore/pages/settingspage.dart';
import 'package:stemxplore/stemhighlight/stem_highlight.dart';
import 'package:stemxplore/steminfo/steminfodetailpage.dart';
//fucntion page imports
import 'package:stemxplore/steminfo/steminfopage.dart';
import 'package:stemxplore/career/careerpage.dart';
import 'package:stemxplore/dailychallenge/dailychallengepage.dart';
import 'package:stemxplore/faq/faqpage.dart';
import 'package:stemxplore/learningmaterial/learningmaterialpage.dart';
import 'package:stemxplore/quizgame/quizgamepage.dart';
import 'package:stemxplore/stemhighlight/stem_highlight.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int navIndex = 0;
  int pageIndex = 0;

  Map? selectedHighlight;
  dynamic selectedStemInfo;

  /// MAIN pages controlled by Bottom Nav
  late final List<Widget> mainPages = [
    Homepage(
      onNavigate: onFeatureNavigate,
      onHighlightTap: onHighlightSelected,
    ),
    const Bookmarkpage(),
    const Infopage(),
    const Settingspage(),
  ];

  /// ALL pages (including detail pages)
  List<Widget> get pages => [
    Homepage(
      onNavigate: onFeatureNavigate,
      onHighlightTap: onHighlightSelected,
    ), // 0 Home
    const Bookmarkpage(), // 1 Bookmark
    const Infopage(), // 2 Info
    const Settingspage(), // 3 Settings
    /// Feature pages
    Steminfopage(onSelect: onStemSelect), // 4
    const Learningmaterialpage(), // 5
    const Quizgamepage(), // 6
    const Careerpage(), // 7
    const Dailychallengepage(), // 8
    const Faqpage(), // 9
    /// Detail pages
    if (selectedHighlight != null)
      StemHighlight(data: selectedHighlight!)
    else
      const SizedBox(), // 10

    if (selectedStemInfo != null)
      StemInfoDetailPage(stemInfo: selectedStemInfo)
    else
      const SizedBox(), // 11
  ];

  void onFeatureNavigate(int index) {
    setState(() {
      pageIndex = index;
      navIndex = 0; // stay on Home tab
    });
  }

  void onHighlightSelected(dynamic highlight) {
    setState(() {
      selectedHighlight = highlight;
      pageIndex = 10;
      navIndex = 0;
    });
  }

  void onStemSelect(dynamic stemInfo) {
    setState(() {
      selectedStemInfo = stemInfo;
      pageIndex = 11;
      navIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// PAGE SWITCHING
        body: IndexedStack(index: pageIndex, children: pages),

        /// BOTTOM NAVIGATION
        bottomNavigationBar: CurvedNavigationBar(
          index: navIndex,
          height: 60,
          backgroundColor: Colors.transparent,
          color: Color.fromARGB(255, 52, 137, 55),
          buttonBackgroundColor: const Color(0xFF3E5F44),
          animationDuration: const Duration(milliseconds: 300),

          items: const [
            Icon(Icons.home, color: Colors.white),
            Icon(Icons.bookmark, color: Colors.white),
            Icon(Icons.info, color: Colors.white),
            Icon(Icons.settings, color: Colors.white),
          ],

          onTap: (index) {
            setState(() {
              navIndex = index;
              pageIndex = index; // direct mapping
            });
          },
        ),
      ),
    );
  }
}
