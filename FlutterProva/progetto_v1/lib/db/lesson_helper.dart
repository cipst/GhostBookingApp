import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/lesson.dart';

class LessonHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<List<Lesson>?> getAllLessons() async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery("""
      SELECT l.*, t.image FROM Lesson l JOIN Teacher t ON l.teacher = t.name
    """);

    if (maps.isEmpty) return null;

    List<Lesson> lessons = <Lesson>[];
    for (Map<String, dynamic> l in maps) {
      lessons.add(Lesson.fromJson(l));
    }

    return lessons;
  }

  static Future<List<Lesson>?> getLessons(DateTime dateTime) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery("""
      SELECT l.*, t.image FROM Lesson AS l JOIN Teacher AS t ON l.teacher = t.name
        WHERE l.dateTime LIKE ?
    """, ["${DateFormat.yMd().format(dateTime)}%"]);

    if (maps.isEmpty) return null;

    List<Lesson> lessons = <Lesson>[];
    for (Map<String, dynamic> l in maps) {
      lessons.add(Lesson.fromJson(l));
    }

    return lessons;
  }

  static Future<Lesson> getLesson(int id) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Lesson", where: "id = ?", whereArgs: [id]);

    if (maps.isEmpty) throw Exception("Lesson table is empty");

    return Lesson.fromJson(maps[0]); // only one lesson, got the first one
  }
}
