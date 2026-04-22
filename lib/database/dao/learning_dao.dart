import 'package:stemxplore/database/db_helper.dart';

class LearningDao {
  static Future<List<Map<String, dynamic>>> getAllLearning() async {
    final db = await DBHelper.getDB();

    final result = await db.rawQuery('''
      SELECT 
        l.learning_id,
        l.learning_title_en,
        l.learning_title_ms,
        l.learning_subject_en,
        l.learning_subject_ms,

        p.page_id,
        p.page_title_en,
        p.page_title_ms,
        p.page_desc_en,
        p.page_desc_ms,
        p.page_order,
        p.bookmark,

        m.media_type,
        m.media_url

      FROM stem_learning l
      LEFT JOIN stem_learning_page p 
        ON l.learning_id = p.learning_id
      LEFT JOIN learning_media m 
        ON p.page_id = m.page_id
      ORDER BY l.learning_id, p.page_order
    ''');

    Map<int, Map<String, dynamic>> learningMap = {};

    for (var row in result) {
      final learningId = int.parse(row['learning_id'].toString());
      final pageId = row['page_id'];

      // create learning if not exists
      if (!learningMap.containsKey(learningId)) {
        learningMap[learningId] = {
          'learning_id': learningId,
          'learning_title_en': row['learning_title_en'],
          'learning_title_ms': row['learning_title_ms'],
          'learning_subject_en': row['learning_subject_en'],
          'learning_subject_ms': row['learning_subject_ms'],
          'pages': <Map<String, dynamic>>[],
        };
      }

      if (pageId != null) {
        // find page inside list
        List pages = learningMap[learningId]!['pages'];

        var page = pages.firstWhere(
          (p) => p['page_id'] == pageId,
          orElse: () {
            final newPage = {
              'page_id': pageId,
              'page_title_en': row['page_title_en'],
              'page_title_ms': row['page_title_ms'],
              'page_desc_en': row['page_desc_en'],
              'page_desc_ms': row['page_desc_ms'],
              'page_order': row['page_order'],
              'bookmark': row['bookmark'],
              'media': <Map<String, dynamic>>[],
            };
            pages.add(newPage);
            return newPage;
          },
        );

        if (row['media_url'] != null) {
          page['media'].add({
            'type': row['media_type'],
            'url': row['media_url'], // LOCAL asset path
          });
        }
      }
    }

    return learningMap.values.toList();
  }
}
