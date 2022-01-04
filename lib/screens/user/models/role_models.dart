class RoleModel {
  RoleModel(
      {required this.role,
      required this.business,
      this.user,
      required this.name});

  int role;
  int business;
  int? user;
  String? name;

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
      role: json["role"],
      business: json["business"],
      user: json["user"],
      name: null);

  Map<String, dynamic> toJson() => {
        "role": role,
        "business": business,
        "user": user,
      };
}
