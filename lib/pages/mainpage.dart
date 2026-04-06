import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stemxplore/career/careerquiz.dart';
import 'package:stemxplore/career/careerresult.dart';

import 'package:stemxplore/learningmaterial/materialdetailpage.dart';
import 'package:stemxplore/pages/bookmarkpage.dart';
import 'package:stemxplore/pages/homepage.dart';
import 'package:stemxplore/pages/infopage.dart';
import 'package:stemxplore/pages/settingspage.dart';
import 'package:stemxplore/quizgame/quizstartpage.dart';
import 'package:stemxplore/quizgame/resultpage.dart';
import 'package:stemxplore/stemhighlight/stem_highlight.dart';
import 'package:stemxplore/steminfo/steminfodetailpage.dart';
//fucntion page imports
import 'package:stemxplore/steminfo/steminfopage.dart';
import 'package:stemxplore/career/careerpage.dart';
import 'package:stemxplore/dailychallenge/dailychallengepage.dart';
import 'package:stemxplore/faq/faqpage.dart';
import 'package:stemxplore/learningmaterial/learningmaterialpage.dart';
import 'package:stemxplore/quizgame/quizgamepage.dart';
import 'package:stemxplore/theme_provider.dart';

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
  dynamic selectedLearningMaterial;

  //quiz
  String? selectedQuizId;
  String? selectedQuizTitle;
  int? quizScore;
  int? quizTotal;

  //career
  bool startCareerQuiz = false;
  int? careerFieldId;

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
    Learningmaterialpage(onSelect: onLearningSelect), // 5

    Quizgamepage(onQuizStart: onQuizStart), // 6
    Careerpage(onStartQuiz: onCareerStart), // 7

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

    if (selectedLearningMaterial != null)
      Materialdetailpage(learningMaterial: selectedLearningMaterial)
    else
      const SizedBox(), // 12

    if (selectedQuizId != null)
      QuizStartPage(
        key: ValueKey(selectedQuizId), // force rebuild when quiz changes
        quizId: selectedQuizId!,
        quizTitle: selectedQuizTitle!,
        onFinishQuiz: onQuizFinish,
      )
    else
      const SizedBox(), // 13
    /// Quiz Result
    if (quizScore != null)
      QuizResultPage(
        score: quizScore!,
        total: quizTotal!,
        onBackHome: onBackHome,
      )
    else
      const SizedBox(), // 14
    /// Career Quiz
    if (startCareerQuiz)
      Careerquiz(
        key: ValueKey(DateTime.now().millisecondsSinceEpoch),
        onFinishCareerQuiz: onCareerFinish,
      )
    else
      const SizedBox(), // 15
    /// Career Result
    if (careerFieldId != null)
      Careerresult(fieldId: careerFieldId!, onBackHome: onBackHome)
    else
      const SizedBox(), // 16
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

  void onLearningSelect(dynamic learningMaterial) {
    setState(() {
      selectedLearningMaterial = learningMaterial;
      pageIndex = 12; // next available index
      navIndex = 0;
    });
  }

  void onQuizStart(String id, String title) {
    setState(() {
      selectedQuizId = id;
      selectedQuizTitle = title;
      pageIndex = 13;
      navIndex = 0;
    });
  }

  void onQuizFinish(int score, int total) {
    setState(() {
      quizScore = score;
      quizTotal = total;
      pageIndex = 14;
    });
  }

  void onBackHome() {
    setState(() {
      pageIndex = 0;
      navIndex = 0;

      selectedQuizId = null;
      quizScore = null;

      startCareerQuiz = false;
      careerFieldId = null;
    });
  }

  void onCareerStart() {
    setState(() {
      careerFieldId = null;
      startCareerQuiz = false; // briefly hide old widget

      startCareerQuiz = true;
      pageIndex = 15;
      navIndex = 0;
    });
  }

  void onCareerFinish(int fieldId) {
    setState(() {
      careerFieldId = fieldId;
      pageIndex = 16;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          color: theme.brightness == Brightness.dark
              ? Color.fromRGBO(179, 204, 161, 1)
              : const Color.fromARGB(255, 52, 137, 55),
          buttonBackgroundColor: theme.brightness == Brightness.dark
              ? Color.fromRGBO(179, 204, 161, 1)
              : const Color.fromARGB(255, 52, 137, 55),
          animationDuration: const Duration(milliseconds: 300),
          items: [
            Icon(
              Icons.home,
              color: theme.brightness == Brightness.dark
                  ? Color.fromARGB(255, 52, 137, 55)
                  : Color.fromRGBO(255, 255, 255, 1),
            ),
            Icon(
              Icons.bookmark,
              color: theme.brightness == Brightness.dark
                  ? Color.fromARGB(255, 52, 137, 55)
                  : Color.fromRGBO(255, 255, 255, 1),
            ),
            Icon(
              Icons.info,
              color: theme.brightness == Brightness.dark
                  ? Color.fromARGB(255, 52, 137, 55)
                  : Color.fromRGBO(255, 255, 255, 1),
            ),
            Icon(
              Icons.settings,
              color: theme.brightness == Brightness.dark
                  ? Color.fromARGB(255, 52, 137, 55)
                  : Color.fromRGBO(255, 255, 255, 1),
            ),
          ],
          onTap: (index) {
            setState(() {
              navIndex = index;
              pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
