class User {
  String name;
  String email;
  String? image;

  User({required this.name, required this.email, this.image});

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "image": image,
      };

  @override
  String toString() {
    return "User: $name, $email";
  }
}
