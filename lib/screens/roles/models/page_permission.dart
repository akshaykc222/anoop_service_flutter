class PagePermission {
  PagePermission({
    this.role,
    required this.pageName,
    required this.edit,
    required this.create,
    required this.update,
    required this.delete,
  });

  int? role;
  int pageName;
  bool edit;
  bool create;
  bool update;
  bool delete;

  factory PagePermission.fromJson(Map<String, dynamic> json) => PagePermission(
        role: json["role"],
        pageName: json["page_name"],
        edit: json["read"],
        create: json["create"],
        update: json["update"],
        delete: json["delete"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "page_name": pageName,
        "read": edit,
        "create": create,
        "update": update,
        "delete": delete,
      };
}
