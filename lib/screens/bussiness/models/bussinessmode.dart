class BusinessModel {
  BusinessModel({
    this.parentCompany,
    this.id,
    required this.name,
    required this.address,
    required this.pincode,
    required this.country,
    required this.state,
    required this.city,
    required this.tax,
    required this.tax1,

  });
  int? id;
  String? parentCompany;
  String name;
  String address;
  int pincode;
  String country;
  String state;
  String city;
  String tax;
  String tax1;

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
        id: json["id"],
        parentCompany: json["parent_company"],
        name: json["name"],
        address: json["address"],
        pincode: json["pin_code"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        tax: json["tax1"],
        tax1: json["tax1"],

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_company": parentCompany,
        "name": name,
        "address": address,
        "pin_code": pincode,
        "country": country,
        "state": state,
        "city": city,
        "tax": tax,
        "tax1": tax,
      };
}
