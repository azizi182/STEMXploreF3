import 'package:stemxplore/database/db_helper.dart';

class CareerJobDao {
  static Future<List<Map<String, dynamic>>> getJobsByField(int fieldId) async {
    final db = await DBHelper.getDB();

    final result = await db.query(
      'career_job',
      where: 'field_id = ?',
      whereArgs: [fieldId],
    );

    return result;
  }
}
