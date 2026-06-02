import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) =>
    json.encode(data.toJson());

class UserResponse {
  List<User> users;

  UserResponse({
    required this.users,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      UserResponse(
        users: List<User>.from(
          json["users"].map((x) => User.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "users": users.map((x) => x.toJson()).toList(),
      };
}

class User {
  String? id;

  String username;

  String firstName;

  String lastName;

  String email;

  String photoUrl;

  bool active;

  User({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photoUrl,
    required this.active,
  });

  factory User.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) =>
      User(
        id: id,
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        photoUrl: json["photoUrl"] ?? '',
        active: json["active"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "photoUrl": photoUrl,
        "active": active,
      };

  User copyWith({
    String? id,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? photoUrl,
    bool? active,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      active: active ?? this.active,
    );
  }
}
