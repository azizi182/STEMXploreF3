import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkManager extends ChangeNotifier {
  static const String _key = 'bookmarked_pages';
  static BookmarkManager? _instance;
  late SharedPreferences _prefs;

  BookmarkManager._create();

  static Future<BookmarkManager> getInstance() async {
    if (_instance == null) {
      _instance = BookmarkManager._create();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<String> getBookmarks() => _prefs.getStringList(_key) ?? [];

  bool isBookmarked(String pageId) => getBookmarks().contains(pageId);

  Future<void> addBookmark(String pageId) async {
    final bookmarks = getBookmarks();
    if (!bookmarks.contains(pageId)) {
      bookmarks.add(pageId);
      await _prefs.setStringList(_key, bookmarks);
      notifyListeners(); // ⚡ notify listeners
    }
  }

  Future<void> removeBookmark(String pageId) async {
    final bookmarks = getBookmarks();
    if (bookmarks.contains(pageId)) {
      bookmarks.remove(pageId);
      await _prefs.setStringList(_key, bookmarks);
      notifyListeners(); // ⚡ notify listeners
    }
  }

  Future<void> toggleBookmark(String pageId) async {
    if (isBookmarked(pageId)) {
      await removeBookmark(pageId);
    } else {
      await addBookmark(pageId);
    }
  }
}
