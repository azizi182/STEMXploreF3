import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> getDB() async {
    if (_db != null) return _db!;

    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'stemxplore.db');

    return await openDatabase(
      path,

      version: 2,

      onCreate: (db, version) async {
        await _createTables(db);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS career_field");
        await db.execute("DROP TABLE IF EXISTS career_job");
        await db.execute("DROP TABLE IF EXISTS career_qustion");
        await db.execute("DROP TABLE IF EXISTS learning_media");
        await db.execute("DROP TABLE IF EXISTS stem_faq");
        await db.execute("DROP TABLE IF EXISTS stem_highlight");
        await db.execute("DROP TABLE IF EXISTS stem_highlight_media");
        await db.execute("DROP TABLE IF EXISTS stem_info");
        await db.execute("DROP TABLE IF EXISTS stem_info_media");
        await db.execute("DROP TABLE IF EXISTS stem_learning");
        await db.execute("DROP TABLE IF EXISTS stem_learning_page");
        await db.execute("DROP TABLE IF EXISTS stem_quiz");
        await db.execute("DROP TABLE IF EXISTS stem_quiz_question");

        await _createTables(db);
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    // career fields table
    await db.execute('''
CREATE TABLE career_field (
  field_id INTEGER PRIMARY KEY,
  field_name TEXT NOT NULL
)
''');

    //career job
    await db.execute('''
CREATE TABLE career_job (
  job_id INTEGER PRIMARY KEY,
  field_id INTEGER,
  job_title_en TEXT,
  desc_en TEXT,
  desc_ms TEXT,
  image TEXT,
  job_title_ms TEXT
)
''');

    //career_qustion
    await db.execute('''
CREATE TABLE career_qustion (
  cquestion_id INTEGER PRIMARY KEY,
  cquestion_en TEXT,
  cquestion_ms TEXT,
  option1_en TEXT,
  option1_ms TEXT,
  option1_field TEXT,
  option2_en TEXT,
  option2_ms TEXT,
  option2_field TEXT,
  option3_en TEXT,
  option3_ms TEXT,
  option3_field TEXT,
  option4_en TEXT,
  option4_ms TEXT,
  option4_field TEXT
)
''');

    //learning media
    await db.execute('''
CREATE TABLE learning_media (
  media_id INTEGER PRIMARY KEY,
  media_type TEXT,
  media_url TEXT,
  page_id INTEGER
)
''');

    //stem faq
    await db.execute('''
CREATE TABLE stem_faq (
  faq_id INTEGER PRIMARY KEY,
  faq_question_en TEXT,
  faq_question_ms TEXT,
  faq_answer_en TEXT,
  faq_answer_ms TEXT,
  faq_image TEXT
)
''');

    //stem highlight
    await db.execute('''
CREATE TABLE stem_highlight (
  highlight_id INTEGER PRIMARY KEY,
  highlight_title_en TEXT,
  highlight_title_ms TEXT,
  highlight_desc_en TEXT,
  highlight_desc_ms TEXT,
  highlight_type TEXT
)
''');

    //stem highlight media
    await db.execute('''
CREATE TABLE stem_highlight_media (
  media_id INTEGER PRIMARY KEY,
  highlight_id INTEGER,
  media_url TEXT
)
''');

    //stem_info
    await db.execute('''
CREATE TABLE stem_info (
  info_id INTEGER PRIMARY KEY,
  info_title_en TEXT,
  info_title_ms TEXT,
  info_desc_en TEXT,
  info_desc_ms TEXT,
  info_type TEXT
)
''');

    //stem_info media
    await db.execute('''
CREATE TABLE stem_info_media (
  media_id INTEGER PRIMARY KEY,
  info_id INTEGER,
  media_url TEXT
)
''');

    //stem learning
    await db.execute('''
CREATE TABLE stem_learning (
  learning_id INTEGER PRIMARY KEY,
  learning_title_en TEXT,
  learning_title_ms TEXT,
  learning_subject_en TEXT,
  learning_subject_ms TEXT
)
''');

    //stem learning page
    await db.execute('''
CREATE TABLE stem_learning_page (
  page_id INTEGER PRIMARY KEY,
  learning_id INTEGER,
  page_title_en TEXT,
  page_title_ms TEXT,
  page_desc_en TEXT,
  page_desc_ms TEXT,
  page_order INTEGER,
  bookmark TEXT DEFAULT 'no'
)
''');

    //stem quiz
    await db.execute('''
CREATE TABLE stem_quiz (
  quiz_id INTEGER PRIMARY KEY,
  quiz_title_en TEXT,
  quiz_title_ms TEXT,
  quiz_subject_en TEXT,
  quiz_subject_ms TEXT,
  quiz_total_question INTEGER
)
''');

    //stem quiz question
    await db.execute('''
CREATE TABLE stem_quiz_question (
  question_id INTEGER PRIMARY KEY,
  quiz_id INTEGER,
  question_text_en TEXT,
  question_text_ms TEXT,
  question_image TEXT,
  opt_a_en TEXT,
  opt_a_ms TEXT,
  opt_a_image TEXT,
  opt_b_en TEXT,
  opt_b_ms TEXT,
  opt_b_image TEXT,
  opt_c_en TEXT,
  opt_c_ms TEXT,
  opt_c_image TEXT,
  opt_d_en TEXT,
  opt_d_ms TEXT,
  opt_d_image TEXT,
  correct_answer_en TEXT,
  correct_answer_ms TEXT
)
''');
  }
}
