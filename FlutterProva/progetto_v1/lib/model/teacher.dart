class Teacher {
  String name;
  String? image;

  Teacher({this.image, required this.name});

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
  };

  @override
  String toString() {
    return "Teacher: $name";
  }
}
