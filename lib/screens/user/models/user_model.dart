import 'package:seed_sales/screens/roles/models/role_model.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.password,
     });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<Roles> _roleslist = <Roles>[];
    if (json['roles'] != null) {
      json['roles'].forEach((v) {
        _roleslist.add(Roles.fromJson(v));
      });
    }
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password']
       );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password1'] = password;
    data['password2'] = password;
   

    return data;
  }
}
