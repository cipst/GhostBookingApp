import 'package:intl/intl.dart';

enum StatusType { active, complete, cancel }

class Booking {
  int? id;
  String user;
  int lesson;
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
    status: StatusType.values[json["status"]], // in db is saved an integer --> need to convert integer into StatusType
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
    return "Booking{\n\t"
        "ID: $id\n\t"
        "lesson ID: $lesson\n\t"
        "user: $user\n\t"
        "status: $status\n\t"
        "reminder: ${reminder!=null ? DateFormat.MMMMd().format(reminder!) : ""} ${reminder!=null ? DateFormat.Hm().format(reminder!) : ""}\n\t"
        "}";
  }
}
