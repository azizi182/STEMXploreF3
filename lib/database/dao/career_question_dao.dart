import 'package:stemxplore/database/db_helper.dart';

class CareerQuestionDao {
  static Future<List<Map<String, dynamic>>> getAllQuestions() async {
    final db = await DBHelper.getDB();

    final result = await db.query('career_qustion');

    return result;
  }
}
