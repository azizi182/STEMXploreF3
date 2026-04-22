import 'dart:convert';
import 'package:flutter/services.dart';
import 'db_helper.dart';
import 'package:sqflite/sqflite.dart';

class InsertData {
  static Future<void> insertAll() async {
    final db = await DBHelper.getDB();

    await _insertCareerField(db);
    await _insertCareerJob(db);
    await _insertCareerQuestion(db);
    await _insertFaq(db);
    await _insertLearningMedia(db);
    await _insertStemHighlight(db);
    await _insertStemMedia(db);
    await _insertStemInfo(db);
    await _insertStemInfoMedia(db);
    await _insertStemLearning(db);
    await _insertStemLearningPage(db);
    await _insertStemQuiz(db);
    await _insertStemQuizQuestion(db);
  }

  // ---------------- CAREER FIELD ----------------
  static Future<void> _insertCareerField(Database db) async {
    String data = await rootBundle.loadString('assets/data/career_field.json');
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'career_field',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // ---------------- CAREER JOB ----------------
  static Future<void> _insertCareerJob(Database db) async {
    String data = await rootBundle.loadString('assets/data/career_job.json');
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'career_job',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // ---------------- CAREER QUESTION ----------------
  static Future<void> _insertCareerQuestion(Database db) async {
    String data = await rootBundle.loadString(
      'assets/data/career_qustion.json',
    );
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'career_qustion',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // ---------------- LEARNING MEDIA ----------------
  static Future<void> _insertLearningMedia(Database db) async {
    String data = await rootBundle.loadString(
      'assets/data/learning_media.json',
    );
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'learning_media',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // ---------------- FAQ ----------------
  static Future<void> _insertFaq(Database db) async {
    String data = await rootBundle.loadString('assets/data/stem_faq.json');
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_faq',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // ---------------- STEM HIGHLIGHT ----------------
  static Future<void> _insertStemHighlight(Database db) async {
    String data = await rootBundle.loadString(
      'assets/data/stem_highlight.json',
    );
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_highlight',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // STEM HIGHLIGHT MEDIA
  static Future<void> _insertStemMedia(Database db) async {
    String data = await rootBundle.loadString(
      'assets/data/stem_highlight_media.json',
    );
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_highlight_media',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // STEM INFO
  static Future<void> _insertStemInfo(Database db) async {
    String data = await rootBundle.loadString('assets/data/stem_info.json');
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_info',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // STEM INFO MEDIA
  static Future<void> _insertStemInfoMedia(Database db) async {
    String data = await rootBundle.loadString(
      'assets/data/stem_info_media.json',
    );
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_info_media',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  //STEM LEARNING
  static Future<void> _insertStemLearning(Database db) async {
    String data = await rootBundle.loadString('assets/data/stem_learning.json');
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_learning',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  //STEM LEARNING PAGE
  static Future<void> _insertStemLearningPage(Database db) async {
    String data = await rootBundle.loadString(
      'assets/data/stem_learning_page.json',
    );
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_learning_page',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  //STEM QUIZ
  static Future<void> _insertStemQuiz(Database db) async {
    String data = await rootBundle.loadString('assets/data/stem_quiz.json');
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_quiz',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  //STEM QUIZ QUESTION
  static Future<void> _insertStemQuizQuestion(Database db) async {
    String data = await rootBundle.loadString(
      'assets/data/stem_quiz_question.json',
    );
    List jsonData = json.decode(data);

    for (var item in jsonData) {
      await db.insert(
        'stem_quiz_question',
        item,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }
}
