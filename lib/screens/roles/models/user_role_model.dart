class RolePermission {
  RolePermission({
    required this.pageName,
    required this.view,
    required this.create,
    required this.edit,
    required this.delete,
  });

  String pageName;
  bool view;
  bool create;
  bool edit;
  bool delete;

  factory RolePermission.fromJson(Map<String, dynamic> json) => RolePermission(
        pageName: json["page_name"],
        view: json["view"],
        create: json["create"],
        edit: json["edit"],
        delete: json["delete"],
      );

  Map<String, dynamic> toJson() => {
        "page_name": pageName,
        "view": view,
        "create": create,
        "edit": edit,
        "delete": delete,
      };
}
