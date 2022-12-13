import 'package:intl/intl.dart';
import 'package:progetto_v1/model/lesson.dart';
import 'package:progetto_v1/model/user.dart';

enum StatusType { active, complete, cancel }

class Booking {
  int? id;
  final User user;
  final Lesson lesson;
  DateTime? reminder;
  StatusType status;

  Booking({
    this.id,
    required this.user,
    required this.lesson,
    required this.status,
    this.reminder,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        user: json["user"],
        lesson: json["lesson"],
        status: StatusType.values[json[
            "status"]], // in db is saved an integer --> need to convert integer into
        reminder: json["reminder"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "lesson": lesson,
        "reminder": reminder,
        "status": status.index
      };

  @override
  String toString() {
    return "Appointment{\n\t$lesson\n\t${DateFormat.MMMMd().format(reminder!)} ${DateFormat.Hm().format(reminder!)}}";
  }
}
