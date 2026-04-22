import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkManager extends ChangeNotifier {
  static const String _key = 'bookmarked_pages';

  SharedPreferences? _prefs;

  BookmarkManager() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  List<String> getBookmarks() => _prefs?.getStringList(_key) ?? [];

  bool isBookmarked(String pageId) =>
      _prefs?.getStringList(_key)?.contains(pageId) ?? false;

  Future<void> addBookmark(String pageId) async {
    final bookmarks = getBookmarks();
    if (!bookmarks.contains(pageId)) {
      bookmarks.add(pageId);
      await _prefs?.setStringList(_key, bookmarks);
      notifyListeners();
    }
  }

  Future<void> removeBookmark(String pageId) async {
    final bookmarks = getBookmarks();
    if (bookmarks.contains(pageId)) {
      bookmarks.remove(pageId);
      await _prefs?.setStringList(_key, bookmarks);
      notifyListeners(); // ⚡ notify listeners
    }
  }

  Future<void> toggleBookmark(String pageId) async {
    if (_prefs == null) return; // ⚠️ prevent crash

    if (isBookmarked(pageId)) {
      await removeBookmark(pageId);
    } else {
      await addBookmark(pageId);
    }
  }
}
