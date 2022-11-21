import 'dart:math';

import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/teacher.dart';

class Lesson {

  Course _course;
  Teacher _teacher;
  DateTime _dateTime;

  Lesson(this._course, this._teacher, this._dateTime);

  static final list = [
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-21 16:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-21 17:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-21 18:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-21 19:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-22 12:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-22 13:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-22 14:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-22 15:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-22 21:00:00"),
    ),
    Lesson(
        Course.list[Random().nextInt(Course.list.length)],
        Teacher.list[Random().nextInt(Teacher.list.length)],
        DateTime.parse("2022-11-22 22:00:00"),
    ),
    Lesson(
      Course.list[Random().nextInt(Course.list.length)],
      Teacher.list[Random().nextInt(Teacher.list.length)],
      DateTime.parse("2022-11-20 23:00:00"),
    ),

  ];

  Course get course => _course;

  Teacher get teacher => _teacher;

  DateTime get dateTime => _dateTime;
}