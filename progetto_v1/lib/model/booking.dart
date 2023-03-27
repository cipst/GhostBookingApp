enum StatusType { active, complete, cancel }

class Booking {
  int? id;
  String user;
  int lesson;
  StatusType status;

  Booking({
    this.id,
    required this.user,
    required this.lesson,
    required this.status,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    user: json["user"],
    lesson: json["lesson"],
    status: StatusType.values[json["status"]], // in db is saved an integer --> need to convert integer into StatusType
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user,
    "lesson": lesson,
    "status": status.index
  };

  @override
  String toString() {
    return "Booking{\n\t"
        "ID: $id\n\t"
        "lesson ID: $lesson\n\t"
        "user: $user\n\t"
        "status: $status\n\t"
        "}";
  }
}
