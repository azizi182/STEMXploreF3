import 'package:stemxplore/database/db_helper.dart';

class FaqDao {
  static Future<List<Map<String, dynamic>>> getFaqs() async {
    final db = await DBHelper.getDB();

    final result = await db.query('stem_faq');

    return result;
  }
}
