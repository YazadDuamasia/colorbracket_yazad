// To parse this JSON data, do
//
//     final homeUserModel = homeUserModelFromJson(jsonString);

import 'dart:convert';

List<HomeUserModel> homeUserModelFromJson(String str) => List<HomeUserModel>.from(json.decode(str).map((x) => HomeUserModel.fromJson(x)));

String homeUserModelToJson(List<HomeUserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeUserModel {
  HomeUserModel({
    this.id,
    this.name,
    this.company,
    this.designation,
  });

  int? id;
  String? name;
  String? company;
  String? designation;

  HomeUserModel copyWith({
    int? id,
    String? name,
    String? company,
    String? designation,
  }) =>
      HomeUserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        company: company ?? this.company,
        designation: designation ?? this.designation,
      );

  factory HomeUserModel.fromJson(Map<String, dynamic> json) => HomeUserModel(
    id: json["id"] ?? null,
    name: json["name"] ?? null,
    company: json["company"] ?? null,
    designation: json["designation"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? null,
    "name": name ?? null,
    "company": company ?? null,
    "designation": designation ?? null,
  };
}
