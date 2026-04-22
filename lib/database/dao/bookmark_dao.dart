import 'package:stemxplore/database/db_helper.dart';

class LearningPageDao {
  static Future<void> updateBookmark(int pageId, String bookmark) async {
    final db = await DBHelper.getDB();

    await db.update(
      'stem_learning_page',
      {'bookmark': bookmark},
      where: 'page_id = ?',
      whereArgs: [pageId],
    );
  }

  // 🔥 ADD THIS
  static Future<List<Map<String, dynamic>>> getBookmarkedPages() async {
    final db = await DBHelper.getDB();

    return await db.rawQuery('''
SELECT 
  p.page_id,
  p.page_title_en,
  p.page_title_ms,
  p.page_desc_en,
  p.page_desc_ms,

  l.learning_subject_en,
  l.learning_subject_ms,
  l.learning_title_en,
  l.learning_title_ms,

  m.media_type,
  m.media_url

FROM stem_learning_page p

LEFT JOIN stem_learning l 
ON p.learning_id = l.learning_id

LEFT JOIN learning_media m 
ON p.page_id = m.page_id

WHERE p.bookmark = 'yes'
''');
  }
}
