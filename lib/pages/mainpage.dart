import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:stemxplore/pages/bookmarkpage.dart';
import 'package:stemxplore/pages/homepage.dart';
import 'package:stemxplore/pages/infopage.dart';
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
  int navIndex = 0; // for bottom navigation index
  int pageIndex = 0; // for all pages

  Map? selectedHighlight;
  dynamic selectedStemInfo;

  List<Widget> get pages => [
    Homepage(
      onNavigate: onFeatureNavigate,
      onHighlightTap: onHighlightSelected,
    ), //0
    const Bookmarkpage(), //1
    const Infopage(), //2
    //function pages
    Steminfopage(onSelect: onStemSelect), //3
    const Learningmaterialpage(), //4
    const Quizgamepage(), //5
    const Careerpage(), //6
    const Dailychallengepage(), //7
    const Faqpage(), //8

    if (selectedHighlight != null) //9
      StemHighlight(data: selectedHighlight!)
    else
      const SizedBox(),

    selectedStemInfo != null
        ? StemInfoDetailPage(stemInfo: selectedStemInfo)
        : const SizedBox(), //10
  ];

  void onFeatureNavigate(int index) {
    setState(() {
      pageIndex = index;
      navIndex = 0;
    });
  }

  //detail of stemhighlight
  void onHighlightSelected(dynamic highlight) {
    setState(() {
      selectedHighlight = highlight;
      pageIndex = pages.indexWhere(
        (page) => page is StemHighlight,
      ); // jump to StemHighlight page
      navIndex = 0; // stay on Home tab
    });
  }

  //detail on steminfo
  void onStemSelect(dynamic stemInfo) {
    setState(() {
      selectedStemInfo = stemInfo;
      pageIndex = pages.indexWhere(
        (page) => page is StemInfoDetailPage,
      ); // jump to detail page
      navIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          ///SWITCH PAGE HERE
          body: IndexedStack(index: pageIndex, children: pages),

          /// Bottom Navigation Bar
          bottomNavigationBar: CurvedNavigationBar(
            index: navIndex,
            height: 60,
            backgroundColor: Colors.transparent, // IMPORTANT for gradient
            color: const Color(0xFF93DA97),
            buttonBackgroundColor: const Color(0xFF3E5F44),
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.easeInOut,

            items: const [
              Icon(Icons.home, size: 24, color: Colors.white),
              Icon(Icons.bookmark, size: 24, color: Colors.white),
              Icon(Icons.info, size: 24, color: Colors.white),
            ],

            onTap: (index) {
              setState(() {
                navIndex = index;
                switch (index) {
                  case 0:
                    pageIndex = 0; // Home
                    break;
                  case 1:
                    pageIndex = 1; // Bookmark
                    break;
                  case 2:
                    pageIndex = 2; // Settings
                    break;
                  case 3:
                    pageIndex = 11; // Info page
                    break;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
