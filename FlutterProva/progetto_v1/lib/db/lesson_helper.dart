import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/db/queries.dart';
import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/model/teacher.dart';

class LessonHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<List<Lesson>?> getAllLessons() async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT l.* FROM Lesson l LEFT JOIN Booking b ON l.id == b.lesson
    WHERE (b.id IS NULL OR b.status == 2)
    ORDER BY l.datetime, l.teacher, l.course
    ''');

    if (maps.isEmpty) return null;

    List<Lesson> lessons = <Lesson>[];
    for (Map<String, dynamic> l in maps) {
      lessons.add(Lesson.fromJson(l));
    }

    return lessons;
  }

  static Future<Lesson?> getLesson(int id) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Lesson", where: "id = ?", whereArgs: [id]);

    if (maps.isEmpty) return null;

    return Lesson.fromJson(maps.first); // only one lesson, got the first one
  }

  static Future<List<Lesson>?> getLessonsByDate(String dateTime) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT l.* FROM Lesson l LEFT JOIN Booking b ON l.id == b.lesson
    WHERE (b.id IS NULL OR b.status == 2) AND l.datetime LIKE ?
    ORDER BY l.datetime, l.teacher, l.course
    ''', ["%$dateTime%"]);

    if (maps.isEmpty) return null;

    List<Lesson> lessons = <Lesson>[];
    for (Map<String, dynamic> l in maps) {
      lessons.add(Lesson.fromJson(l));
    }

    return lessons;
  }

  static Future<List<Lesson>?> getLessonsByCourse(String course) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT l.* FROM Lesson l LEFT JOIN Booking b ON l.id == b.lesson
    WHERE (b.id IS NULL OR b.status == 2) AND l.course = ?
    ORDER BY l.datetime, l.teacher, l.course
    ''', [course]);

    if (maps.isEmpty) return null;

    List<Lesson> lessons = <Lesson>[];
    for (Map<String, dynamic> l in maps) {
      lessons.add(Lesson.fromJson(l));
    }

    return lessons;
  }

  static Future<List<Lesson>?> getLessonsByTeacher(String teacher) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT l.* FROM Lesson l LEFT JOIN Booking b ON l.id == b.lesson
    WHERE (b.id IS NULL OR b.status == 2) AND l.teacher = ?
    ORDER BY l.datetime, l.course, l.teacher
    ''', [teacher]);

    if (maps.isEmpty) return null;

    List<Lesson> lessons = <Lesson>[];
    for (Map<String, dynamic> l in maps) {
      lessons.add(Lesson.fromJson(l));
    }

    return lessons;
  }
}
