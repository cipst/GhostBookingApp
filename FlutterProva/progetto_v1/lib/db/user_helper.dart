import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/user.dart';

class UserHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<User> getUser(String email, String password) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      "User",
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );

    if (maps.isEmpty) throw Exception("User table is empty");

    return User.fromJson(maps[0]);
  }
}
