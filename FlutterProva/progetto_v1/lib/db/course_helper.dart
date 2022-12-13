import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/course.dart';

class CourseHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<List<Course>> getAllCourses() async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Course");

    if (maps.isEmpty) throw Exception("Course table is empty");

    List<Course> courses = <Course>[];
    int i = 0;
    for (Map<String, dynamic> c in maps) {
      courses[i++] = Course.fromJson(c);
    }

    return courses;
  }

  static Future<Course> getCourse(String name) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps =
        await db.query("Course", where: "name = ?", whereArgs: [name]);

    if (maps.isEmpty) throw Exception("Course table is empty");

    return Course.fromJson(maps[0]); // only one course, got the first one
  }
}
