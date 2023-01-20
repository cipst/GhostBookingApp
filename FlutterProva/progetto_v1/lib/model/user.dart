class User {
  String name;
  String email;
  String phone;
  String image;

  User({required this.name, required this.email, required this.phone, required this.image});

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
  };

  @override
  String toString() {
    return "User: $name, $email, $phone, $image";
  }
}
