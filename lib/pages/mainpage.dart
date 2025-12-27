import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stemxplore/pages/bookmarkpage.dart';
import 'package:stemxplore/pages/homepage.dart';
import 'package:stemxplore/pages/settingpage.dart';
import 'package:stemxplore/stemhighlight/stem_highlight.dart';
//fucntion page imports
import 'package:stemxplore/steminfo/steminfopage.dart';
import 'package:stemxplore/career/careerpage.dart';
import 'package:stemxplore/dailychallenge/dailychallengepage.dart';
import 'package:stemxplore/faq/faqpage.dart';
import 'package:stemxplore/learningmaterial/learningmaterialpage.dart';
import 'package:stemxplore/quizgame/quizgamepage.dart';
import 'package:stemxplore/steminfo/steminfopage.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentIndex = 0;

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      Homepage(
        onNavigate: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      const Bookmarkpage(),
      const Settingpage(),
      //function pages
      const Steminfopage(),
      const Learningmaterialpage(),
      const Careerpage(),
      const Dailychallengepage(),
      const Faqpage(),
      const Quizgamepage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          ///SWITCH PAGE HERE
          body: pages[currentIndex],

          /// Bottom Navigation Bar
          bottomNavigationBar: Container(
            color: const Color(0xFF93DA97),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: GNav(
              gap: 8,
              padding: const EdgeInsets.all(12),
              tabBackgroundColor: const Color(
                0xFF3E5F44,
              ), // tab background color
              color: Colors.black,
              activeColor: Colors.white,
              selectedIndex: currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              tabs: const [
                GButton(icon: Icons.home),
                GButton(icon: Icons.bookmark),
                GButton(icon: Icons.settings),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
