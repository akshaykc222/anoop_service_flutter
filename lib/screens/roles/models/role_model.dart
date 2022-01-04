class Roles {
  int? id;
  String roleName;

  Roles({ this.id, required this.roleName});

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(id: json['id'], roleName: json['role_name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role_name'] = roleName;
    return data;
  }
}
