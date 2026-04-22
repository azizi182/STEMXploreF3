import 'package:stemxplore/database/db_helper.dart';

class HighlightDao {
  static Future<List<Map<String, dynamic>>> getHighlights() async {
    final db = await DBHelper.getDB();

    final result = await db.rawQuery('''
      SELECT 
        h.highlight_id,
        h.highlight_title_en,
        h.highlight_title_ms,
        h.highlight_desc_en,
        h.highlight_desc_ms,
        h.highlight_type,
        m.media_url
      FROM stem_highlight h
      LEFT JOIN stem_highlight_media m 
      ON h.highlight_id = m.highlight_id
      ORDER BY h.highlight_id
    ''');

    Map<int, Map<String, dynamic>> grouped = {};

    for (var row in result) {
      final id = int.parse(row['highlight_id'].toString());

      if (!grouped.containsKey(id)) {
        grouped[id] = {
          'highlight_id': id,
          'highlight_title_en': row['highlight_title_en'],
          'highlight_title_ms': row['highlight_title_ms'],
          'highlight_desc_en': row['highlight_desc_en'],
          'highlight_desc_ms': row['highlight_desc_ms'],
          'highlight_type': row['highlight_type'],
          'media': <String>[],
        };
      }

      if (row['media_url'] != null) {
        grouped[id]!['media'].add(row['media_url']);
      }
    }

    return grouped.values.toList();
  }
}
