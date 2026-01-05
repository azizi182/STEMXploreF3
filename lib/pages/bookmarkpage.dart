import 'package:flutter/material.dart';
import 'package:stemxplore/gradient_background.dart';

class Bookmarkpage extends StatefulWidget {
  const Bookmarkpage({super.key});

  @override
  State<Bookmarkpage> createState() => _BookmarkpageState();
}

class _BookmarkpageState extends State<Bookmarkpage> {
  //List<Map<String, dynamic>> bookmarks = [];

  @override
  // void initState() {
  //   super.initState();
  //   BookmarkManager().init().then((_) {
  //     setState(() {
  //       bookmarks = BookmarkManager().getBookmarks('learning');
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(appBar: AppBar(title: Text('Bookmarks'))),
    );
  }
}
