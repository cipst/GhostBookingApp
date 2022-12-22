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

  static Database? _database;
  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }

  static final _teachers = [
    Teacher(
      name: "Paolo Rossi",
      image: "https://minimaltoolkit.com/images/randomdata/male/47.jpg",
    ),
    Teacher(
      name: "Robert Green",
      image: "https://minimaltoolkit.com/images/randomdata/male/76.jpg",
    ),
    Teacher(
      name: "Luca Gialli",
      image: "https://minimaltoolkit.com/images/randomdata/male/43.jpg",
    ),
    Teacher(
      name: "Jennifer Blue",
      image: "https://minimaltoolkit.com/images/randomdata/female/27.jpg",
    ),
    Teacher(
      name: "Susan Violet",
      image: "https://minimaltoolkit.com/images/randomdata/female/103.jpg",
    ),
    Teacher(
      name: "John Black",
      image: "https://minimaltoolkit.com/images/randomdata/male/54.jpg",
    ),
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
  static final _lessons = [
    Lesson(
        course: _courses[0],
        teacher: _teachers[0],
        dateTime: DateTime.parse("2023-01-09 15:00")
    ),
    Lesson(
        course: _courses[0],
        teacher: _teachers[1],
        dateTime: DateTime.parse("2023-01-09 15:00")
    ),
    Lesson(
        course: _courses[0],
        teacher: _teachers[2],
        dateTime: DateTime.parse("2023-01-09 15:00")
    ),
    Lesson(
        course: _courses[1],
        teacher: _teachers[0],
        dateTime: DateTime.parse("2023-01-09 16:00")
    ),
    Lesson(
        course: _courses[1],
        teacher: _teachers[5],
        dateTime: DateTime.parse("2023-01-10 16:00")
    ),
    Lesson(
        course: _courses[1],
        teacher: _teachers[4],
        dateTime: DateTime.parse("2023-01-10 16:00")
    ),
    Lesson(
        course: _courses[2],
        teacher: _teachers[3],
        dateTime: DateTime.parse("2023-01-10 17:00")
    ),
    Lesson(
        course: _courses[2],
        teacher: _teachers[5],
        dateTime: DateTime.parse("2023-01-11 17:00")
    ),
    Lesson(
        course: _courses[3],
        teacher: _teachers[1],
        dateTime: DateTime.parse("2023-01-11 18:00")
    ),
    Lesson(
        course: _courses[4],
        teacher: _teachers[1],
        dateTime: DateTime.parse("2023-01-11 19:00")
    ),
  ];

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    debugPrint("Opening Database...");
    return await openDatabase(path, version: _dbVersion, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
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
        "phone": "391234567890"
      });

      /* TEACHERS INSERT */
      for (final t in _teachers) {
        await db.insert("Teacher", t.toJson());
      }

      /* COURSES INSERT */
      for (final c in _courses) {
        await db.insert("Course", c.toJson());
      }

      /* LESSONS INSERT */
      for (final l in _lessons) {
        debugPrint(l.toJson().toString());
        await db.insert("Lesson", l.toJson());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
    debugPrint("Closing Database...");
  }

  Future drop() async {
    final db = await instance.database;
    db.execute("DROP TABLE User;");
    db.execute("DROP TABLE Teacher;");
    db.execute("DROP TABLE Course;");
    db.execute("DROP TABLE Lesson;");
    db.execute("DROP TABLE Booking;");
    debugPrint("DROPPING Tables...");
  }

}
