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
    ${Queries.getLessons}
    WHERE b.id IS NULL
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

  static Future<List<Lesson>?> getLessonsByDate(DateTime dateTime) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    ${Queries.getLessons}
    WHERE b.id IS NULL AND l.datetime LIKE ?
    ''', ["${DateFormat.yMd().format(dateTime)}%"]);

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
    ${Queries.getLessons}
    WHERE b.id IS NULL AND l.course = ?
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
    ${Queries.getLessons}
    WHERE b.id IS NULL AND l.teacher = ?
    ''', [teacher]);

    if (maps.isEmpty) return null;

    List<Lesson> lessons = <Lesson>[];
    for (Map<String, dynamic> l in maps) {
      lessons.add(Lesson.fromJson(l));
    }

    return lessons;
  }
}
