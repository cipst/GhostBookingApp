import 'dart:math';

import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/teacher.dart';

class Lesson {

  Course _course;
  Teacher _teacher;
  // DateTime _dateTime;

  Lesson(this._course, this._teacher);

  static final list = [
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        // DateTime.now().add(const Duration(hours: 1)),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        // DateTime.now().add(const Duration(hours: 2)),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        // DateTime.now().add(const Duration(hours: 3)),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        // DateTime.now().add(const Duration(hours: 4)),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        // DateTime.parse("2022-11-21 16:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        // DateTime.parse("2022-11-21 17:00:00"),
    ),
  ];

  Course get course => _course;

  Teacher get teacher => _teacher;

  // DateTime get dateTime => _dateTime;

  @override
  String toString() {
    return "Lesson{\n\t$teacher\n\t$course}";
  }
}