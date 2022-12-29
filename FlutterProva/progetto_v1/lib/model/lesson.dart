import 'package:intl/intl.dart';
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

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    id: json["id"],
    course: Course(name: json["course"]),
    teacher: Teacher(name: json["teacher"], image: json["image"]),
    dateTime: DateFormat("MM/dd/yyyy HH:mm").parse(json["dateTime"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course": course.name,
    "teacher": teacher.name,
    "dateTime": "${DateFormat.yMd().format(dateTime)} ${DateFormat.Hm().format(dateTime)}",
  };


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Lesson &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode =>
      id.hashCode ^ course.hashCode ^ teacher.hashCode ^ dateTime.hashCode;

  @override
  String toString() {
    return "Lesson{\n\t$teacher\n\t$course}";
  }
}
