import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/teacher.dart';

class TeacherHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<List<Teacher>?> getAllTeachers() async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query("Teacher");

    if (maps.isEmpty) return null;

    List<Teacher> teachers = <Teacher>[];
    for (Map<String, dynamic> t in maps) {
      teachers.add(Teacher.fromJson(t));
    }

    return teachers;
  }
}
