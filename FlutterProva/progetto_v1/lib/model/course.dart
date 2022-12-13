class Course {
  String name;

  Course({required this.name});

  // static final list = [
  //   Course("Mathematics"),
  //   Course("Science"),
  //   Course("Art"),
  //   Course("Music"),
  //   Course("English"),
  //   Course("Geometry"),
  //   Course("Geography"),
  //   Course("Literature")
  // ];

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
