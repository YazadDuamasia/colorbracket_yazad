// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.userId,
    this.password,
  });

  int? id;
  String? name;
  String? userId;
  String? password;

  UserModel copyWith({
    int? id,
    String? name,
    String? userId,
    String? password,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        userId: userId ?? this.userId,
        password: password ?? this.password,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? null,
        name: json["name"] ?? null,
        userId: json["user_id"] ?? null,
        password: json["password"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "name": name ?? null,
        "user_id": userId ?? null,
        "password": password ?? null,
      };
}
