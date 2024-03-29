import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/course.dart';

class CourseHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<List<Course>?> getAllCourses() async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Course");

    if (maps.isEmpty) return null;

    List<Course> courses = <Course>[];
    for (Map<String, dynamic> c in maps) {
      courses.add(Course.fromJson(c));
    }

    return courses;
  }
}
