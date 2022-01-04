import 'dart:convert';

class CategoriesModel {
  CategoriesModel({
    this.id,
    this.createdUser,
    required this.name,
    this.createdDate,
  });

  int? id;
  int? createdUser;
  String name;
  String? createdDate;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["id"],
        createdUser: json["created_user"],
        name: json["name"],
        createdDate: json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_user": createdUser,
        "name": name,
        "created_date": createdDate,
      };
}
