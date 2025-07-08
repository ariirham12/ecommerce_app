class User {
  final String id, username, fullname;
  User({required this.id, required this.username, required this.fullname});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      fullname: json['fullname'],
    );
  }
}
