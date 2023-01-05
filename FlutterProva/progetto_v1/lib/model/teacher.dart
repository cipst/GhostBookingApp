class Teacher {
  String name;

  Teacher({required this.name});

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };

  @override
  String toString() {
    return "Teacher: $name";
  }
}
