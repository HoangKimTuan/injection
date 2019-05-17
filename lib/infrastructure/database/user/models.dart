import 'package:meta/meta.dart';

class User {
  int id;
  String name;
  String username;
  String email;

  User({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.email
  });

  factory User.fromMap(Map map) => User(
      id: map["id"],
      name: map["name"],
      username: map["username"],
      email: map["email"]
  );

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["username"] = username;
    map["email"] = email;
    return map;
  }
}