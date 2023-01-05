class Course {
  String name;

  Course({required this.name});

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };

  @override
  String toString() {
    return "Course: $name";
  }
}
