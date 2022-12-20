// To parse this JSON data, do
//
//     final viewMoreEmployeeModel = viewMoreEmployeeModelFromJson(jsonString);

import 'dart:convert';

List<ViewMoreEmployeeModel> viewMoreEmployeeModelFromJson(String str) => List<ViewMoreEmployeeModel>.from(json.decode(str).map((x) => ViewMoreEmployeeModel.fromJson(x)));

String viewMoreEmployeeModelToJson(List<ViewMoreEmployeeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewMoreEmployeeModel {
  ViewMoreEmployeeModel({
    this.id,
    this.name,
    this.rating,
    this.company,
    this.interests,
    this.viewMore,
    this.designation,
    this.companyLogo,
    this.jobDescripton,
  });

  int? id;
  String? name;
  String? rating;
  String? company;
  String? interests;
  String? viewMore;
  String? designation;
  String? companyLogo;
  String? jobDescripton;

  ViewMoreEmployeeModel copyWith({
    int? id,
    String? name,
    String? rating,
    String? company,
    String? interests,
    String? viewMore,
    String? designation,
    String? companyLogo,
    String? jobDescripton,
  }) =>
      ViewMoreEmployeeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        rating: rating ?? this.rating,
        company: company ?? this.company,
        interests: interests ?? this.interests,
        viewMore: viewMore ?? this.viewMore,
        designation: designation ?? this.designation,
        companyLogo: companyLogo ?? this.companyLogo,
        jobDescripton: jobDescripton ?? this.jobDescripton,
      );

  factory ViewMoreEmployeeModel.fromJson(Map<String, dynamic> json) => ViewMoreEmployeeModel(
    id: json["id"] ?? null,
    name: json["name"] ?? null,
    rating: json["rating"] ?? null,
    company: json["company"] ?? null,
    interests: json["interests"] ?? null,
    viewMore: json["view_more"] ?? null,
    designation: json["designation"] ?? null,
    companyLogo: json["company_logo"] ?? null,
    jobDescripton: json["job_descripton"] ?? null,
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? null,
    "name": name ?? null,
    "rating": rating ?? null,
    "company": company ?? null,
    "interests": interests ?? null,
    "view_more": viewMore ?? null,
    "designation": designation ?? null,
    "company_logo": companyLogo ?? null,
    "job_descripton": jobDescripton ?? null,
  };
}
