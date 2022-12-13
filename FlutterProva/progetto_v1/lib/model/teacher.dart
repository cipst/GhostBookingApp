class Teacher {
  String name;
  String image;

  Teacher({required this.name, required this.image});

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
