import 'package:stemxplore/database/db_helper.dart';

class StemInfoDao {
  static Future<List<Map<String, dynamic>>> getAllInfo() async {
    final db = await DBHelper.getDB();

    final result = await db.rawQuery('''
      SELECT 
        i.info_id,
        i.info_title_en,
        i.info_title_ms,
        i.info_desc_en,
        i.info_desc_ms,
        i.info_type,
        m.media_url
      FROM stem_info i
      LEFT JOIN stem_info_media m 
      ON i.info_id = m.info_id
      ORDER BY i.info_id
    ''');

    Map<int, Map<String, dynamic>> grouped = {};

    for (var row in result) {
      final id = int.parse(row['info_id'].toString());

      if (!grouped.containsKey(id)) {
        grouped[id] = {
          'info_id': id,
          'info_title_en': row['info_title_en'],
          'info_title_ms': row['info_title_ms'],
          'info_desc_en': row['info_desc_en'],
          'info_desc_ms': row['info_desc_ms'],
          'info_type': row['info_type'],
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
