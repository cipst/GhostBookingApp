import 'package:intl/intl.dart';
import 'package:progetto_v1/model/lesson.dart';

class Appointment {
  Lesson _lesson;
  DateTime _dateTime;

  Appointment(this._lesson, this._dateTime);

  Lesson get lesson => _lesson;
  DateTime get dateTime => _dateTime;

  @override
  String toString() {
    return "Appointment{\n\t$lesson\n\t${DateFormat.MMMMd().format(_dateTime)} ${DateFormat.Hm().format(_dateTime)}}";
  }
}