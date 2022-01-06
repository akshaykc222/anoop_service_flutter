import 'dart:convert';

class CustomerModel {
  CustomerModel({
    this.id,
    this.createdUser,
    this.name,
    this.age,
    this.mail,
    required this.phone,
    this.blood,
    required this.country,
    required this.state,
    required this.city,
    required this.pincode,
    required this.address,
    this.createdDate,
    required this.insurance_comapny,
    required this.insurance_expiry,
    required this.insurance_num,
  });

  int? id;
  int? createdUser;
  String? name;
  int? age;
  String? mail;
  String phone;
  dynamic blood;
  String country;
  String state;
  String city;
  int pincode;
  String address;
  DateTime? createdDate;
  String insurance_comapny;
  String insurance_expiry;
  String insurance_num;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        createdUser: json["created_user"],
        mail: json['email'],
        name: json["name"],
        age: json["age"],
        phone: json["phone"],
        blood: json["blood"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        address: json["address"],
        createdDate: DateTime.parse(
          json["created_date"],
        ),
        insurance_comapny: json['insurance_comapny'],
        insurance_expiry: json['insurance_expiry'],
        insurance_num: json['insurance_num'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_user": createdUser,
        "name": name,
        "email": mail,
        "age": age,
        "phone": phone,
        "blood": blood,
        "country": country,
        "state": state,
        "city": city,
        "pincode": pincode,
        "address": address,
        "insurance_comapny": insurance_comapny,
        "insurance_num": insurance_num,
        "insurance_expiry": insurance_expiry,
        "created_date":
            createdDate != null ? createdDate!.toIso8601String() : null,
      };
}
