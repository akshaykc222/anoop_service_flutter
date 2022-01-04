class PageModel {
  PageModel({
   required this.id,
    required this.createdUser,
    required this.pageName,
    required this.createdDate,
  });

  int id;
  int createdUser;
  String pageName;
  DateTime createdDate;

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
    id: json["id"],
    createdUser: json["created_user"],
    pageName: json["page_name"],
    createdDate: DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_user": createdUser,
    "page_name": pageName,
    "created_date": createdDate.toIso8601String(),
  };
}