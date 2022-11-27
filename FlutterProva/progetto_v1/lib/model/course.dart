class Course {
  final String _name;

  Course(this._name);

  static final list = [
    Course("Mathematics"),
    Course("Science"),
    Course("Art"),
    Course("Music"),
    Course("English"),
    Course("Geometry"),
    Course("Geography"),
    Course("Literature")
  ];

  String get name => _name;

  @override
  String toString() {
    return "Course: $name";
  }
}