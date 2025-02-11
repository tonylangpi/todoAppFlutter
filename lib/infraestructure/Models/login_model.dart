// To parse this JSON data, do
//
//     final loginPost = loginPostFromJson(jsonString);

import 'dart:convert';

LoginPost loginPostFromJson(String str) => LoginPost.fromJson(json.decode(str));

String loginPostToJson(LoginPost data) => json.encode(data.toJson());

class LoginPost {
  final String message;
  final Person? person; // Cambiado a Person?
  final int status;

  LoginPost({
    required this.message,
    this.person, // Cambiado a opcional
    required this.status,
  });

  factory LoginPost.fromJson(Map<String, dynamic> json) => LoginPost(
    message: json["message"],
    person: json["Person"] != null ? Person.fromJson(json["Person"]) : null, // Manejo de null
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "Person": person?.toJson(), // Manejo de null
    "status": status,
  };
}

class Person {
  final int id;
  final String name;
  final String email;
  final String code;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.code,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    code: json["code"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "code": code,
    "phone": phone,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
