import 'dart:ui';

class ProductModel {
  ProductModel({
    this.id,
    this.createdUser,
    required this.name,
    required this.purchaseRate,
    required this.mrp,
    required this.salesPercentage,
    required this.salesRate,
    required this.taxRate,
    this.duration,
    this.is_product,
    this.expiryDate,
    this.createdDate,
    required this.subCategory,
  });

  int? id;
  int? createdUser;
  String name;
  bool? is_product;
  double purchaseRate;
  double mrp;
  double salesPercentage;
  double salesRate;
  double taxRate;
  double? duration;
  DateTime? expiryDate;
  DateTime? createdDate;
  int subCategory;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        createdUser: json["created_user"],
        name: json["name"],
        purchaseRate: json["purchase_rate"].toDouble(),
        mrp: json["mrp"].toDouble(),
        salesPercentage: json["sales_percentage"].toDouble(),
        salesRate: json["sales_rate"].toDouble(),
        taxRate: json["tax_rate"].toDouble(),
        duration: json["duration"].toDouble(),
        is_product: json['is_product'],
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.parse(json["expiry_date"]),
        createdDate: DateTime.parse(json["created_date"]),
        subCategory: json["subCategory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_user": createdUser,
        "name": name,
        "purchase_rate": purchaseRate,
        "mrp": mrp,
        "is_product": is_product,
        "sales_percentage": salesPercentage,
        "sales_rate": salesRate,
        "tax_rate": taxRate,
        "duration": duration,
        "expiry_date": expiryDate != null
            ? "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}"
            : null,
        "created_date":
            createdDate != null ? createdDate!.toIso8601String() : null,
        "subCategory": subCategory,
      };
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => hashValues(id, name);
}
