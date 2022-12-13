import 'package:progetto_v1/model/course.dart';
import 'package:progetto_v1/model/teacher.dart';

class Lesson {
  int? id;
  final Course course;
  final Teacher teacher;
  final DateTime dateTime;

  Lesson({
    this.id,
    required this.course,
    required this.teacher,
    required this.dateTime,
  });

  // static final list = [
  //   Lesson(
  //     Course.list[Random().nextInt(Course.list.length)],
  //     Teacher.list[Random().nextInt(Teacher.list.length)],
  //   ),
  //   Lesson(
  //     Course.list[Random().nextInt(Course.list.length)],
  //     Teacher.list[Random().nextInt(Teacher.list.length)],
  //   ),
  //   Lesson(
  //     Course.list[Random().nextInt(Course.list.length)],
  //     Teacher.list[Random().nextInt(Teacher.list.length)],
  //   ),
  //   Lesson(
  //     Course.list[Random().nextInt(Course.list.length)],
  //     Teacher.list[Random().nextInt(Teacher.list.length)],
  //   ),
  //   Lesson(
  //     Course.list[Random().nextInt(Course.list.length)],
  //     Teacher.list[Random().nextInt(Teacher.list.length)],
  //   ),
  //   Lesson(
  //     Course.list[Random().nextInt(Course.list.length)],
  //     Teacher.list[Random().nextInt(Teacher.list.length)],
  //   ),
  // ];

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        course: json["course"],
        teacher: json["teacher"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course": course,
        "teacher": teacher,
        "dateTime": dateTime,
      };

  @override
  String toString() {
    return "Lesson{\n\t$teacher\n\t$course}";
  }
}
