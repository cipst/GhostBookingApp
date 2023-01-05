import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:progetto_v1/db/queries.dart';
import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/model/teacher.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const int _dbVersion = 1;
  static const String _dbName = "booking.db";
  static final DBHelper instance = DBHelper._init();

  static final _teachers = [
    Teacher(name: "Paolo Rossi"),
    Teacher(name: "Robert Green"),
    Teacher(name: "Francesco Azzurro"),
    Teacher(name: "Jennifer Blue"),
    Teacher(name: "Susan Violet"),
    Teacher(name: "John Black"),
  ];
  static final _courses = [
    Course(name: "Mathematics"),
    Course(name: "Science"),
    Course(name: "Art"),
    Course(name: "Music"),
    Course(name: "English"),
    Course(name: "Geometry"),
    Course(name: "Geography"),
    Course(name: "Literature")
  ];
  static final _dates = [
    DateTime.parse("2023-01-09 15:00"),
    DateTime.parse("2023-01-09 16:00"),
    DateTime.parse("2023-01-09 17:00"),
    DateTime.parse("2023-01-09 18:00"),
    DateTime.parse("2023-01-09 19:00"),

    DateTime.parse("2023-01-10 15:00"),
    DateTime.parse("2023-01-10 16:00"),
    DateTime.parse("2023-01-10 17:00"),
    DateTime.parse("2023-01-10 18:00"),
    DateTime.parse("2023-01-10 19:00"),

    DateTime.parse("2023-01-11 15:00"),
    DateTime.parse("2023-01-11 16:00"),
    DateTime.parse("2023-01-11 17:00"),
    DateTime.parse("2023-01-11 18:00"),
    DateTime.parse("2023-01-11 19:00"),

    DateTime.parse("2023-01-12 15:00"),
    DateTime.parse("2023-01-12 16:00"),
    DateTime.parse("2023-01-12 17:00"),
    DateTime.parse("2023-01-12 18:00"),
    DateTime.parse("2023-01-12 19:00"),

    DateTime.parse("2023-01-13 15:00"),
    DateTime.parse("2023-01-13 16:00"),
    DateTime.parse("2023-01-13 17:00"),
    DateTime.parse("2023-01-13 18:00"),
    DateTime.parse("2023-01-13 19:00"),

    DateTime.parse("2023-01-16 15:00"),
    DateTime.parse("2023-01-16 16:00"),
    DateTime.parse("2023-01-16 17:00"),
    DateTime.parse("2023-01-16 18:00"),
    DateTime.parse("2023-01-16 19:00"),

    DateTime.parse("2023-01-17 15:00"),
    DateTime.parse("2023-01-17 16:00"),
    DateTime.parse("2023-01-17 17:00"),
    DateTime.parse("2023-01-17 18:00"),
    DateTime.parse("2023-01-17 19:00"),
  ];
  static final _lessons = [];

  static Database? _database;
  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    debugPrint("Opening Database...");
    debugPrint("DATABASE INFO:\n\t"
        "PATH: $path\n\t"
        "VERSION: $_dbVersion");
    return await openDatabase(path, version: _dbVersion, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    debugPrint("Creating Tables...");
    try {
      /* TABLES CREATIONS */
      await db.execute(Queries.createUserTable);
      await db.execute(Queries.createTeacherTable);
      await db.execute(Queries.createCourseTable);
      await db.execute(Queries.createLessonTable);
      await db.execute(Queries.createBookingTable);

      /* USER INSERT */
      await db.insert("User", {
        "name": "Stefano Cipolletta",
        "email": "stefano.cipolletta@gmail.com",
        "password": "Qwerty123_",
        "phone": "391234567890",
        "image": "",
      });

      /* TEACHERS INSERT */
      for (final t in _teachers) {
        await db.insert("Teacher", t.toJson());
      }

      /* COURSES INSERT */
      for (final c in _courses) {
        await db.insert("Course", c.toJson());
      }

      _createLessons();

      /* LESSONS INSERT */
      for (final l in _lessons) {
        await db.insert("Lesson", l.toJson());
      }

      debugPrint("Table Created Successfully!");
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("Table Creation Failed!");
    }
  }

  /// foreach teacher, foreach course and foreach available date, create a lesson
  _createLessons() {
    for (var teacher in _teachers) {
      for(var course in _courses) {
        for (var date in _dates) {
          _lessons.add(Lesson(
              teacher: teacher.name,
              course: course.name,
              dateTime: date
          ));
        }
      }
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
    debugPrint("Closing Database...");
  }

  Future delete() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    debugPrint("DELETING DATABASE...");
    deleteDatabase(path);
  }

}
