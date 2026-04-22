import 'package:stemxplore/database/db_helper.dart';

class QuizDao {
  static Future<List<Map<String, dynamic>>> getAllQuizzes() async {
    final db = await DBHelper.getDB();

    return await db.rawQuery('''
      SELECT 
        quiz_id,
        quiz_title_en,
        quiz_title_ms,
        quiz_subject_en,
        quiz_subject_ms,
        quiz_total_question
      FROM stem_quiz
      ORDER BY quiz_id ASC
    ''');
  }
}
