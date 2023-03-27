import 'package:progetto_v1/db/db_helper.dart';
import 'package:progetto_v1/model/user.dart';
import 'package:sqflite/sqflite.dart';

class UserHelper {
  static final DBHelper _instance = DBHelper.instance;

  static Future<User?> getUser(String email, String password) async {
    final db = await _instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      "User",
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );

    if (maps.isEmpty) return null;

    return User.fromJson(maps.first);
  }

  static Future updateImage(String email, String imageName) async {
    final db = await _instance.database;
    await db.update("User", {"image": imageName},
        where: "email = ?",
        whereArgs: [email],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
