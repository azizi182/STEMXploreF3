import 'package:stemxplore/database/db_helper.dart';

class QuizDetailDao {
  static Future<List<Map<String, dynamic>>> getQuizWithQuestions(
    int quizId,
  ) async {
    final db = await DBHelper.getDB();

    return await db.query(
      'stem_quiz_question',
      where: 'quiz_id = ?',
      whereArgs: [quizId],
      orderBy: 'question_id ASC',
    );
  }
}
