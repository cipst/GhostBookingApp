class Teacher {

  final String _name;
  final String _image;

  Teacher(this._name, this._image);

  static final list = [
    Teacher("Paolo Rossi", "https://minimaltoolkit.com/images/randomdata/male/47.jpg"),
    Teacher("Robert Green", "https://minimaltoolkit.com/images/randomdata/male/76.jpg"),
    Teacher("Luca Gialli", "https://minimaltoolkit.com/images/randomdata/male/43.jpg"),
    Teacher("Jennifer Blue", "https://minimaltoolkit.com/images/randomdata/female/27.jpg"),
    Teacher("Susan Violet", "https://minimaltoolkit.com/images/randomdata/female/103.jpg"),
    Teacher("John Black", "https://minimaltoolkit.com/images/randomdata/male/54.jpg"),
  ];

  String? get name => _name;

  String? get image => _image;


}