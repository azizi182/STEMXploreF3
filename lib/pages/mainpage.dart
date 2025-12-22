import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stemxplore/pages/bookmarkpage.dart';
import 'package:stemxplore/pages/homepage.dart';
import 'package:stemxplore/pages/settingpage.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentIndex = 0;

  final List<Widget> pages = const [Homepage(), Bookmarkpage(), Settingpage()];

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
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.bookmark, text: 'Bookmarks'),
                GButton(icon: Icons.settings, text: 'Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
