class DesingationModel {
  int? id;
  String designation;

  DesingationModel({this.id, required this.designation});

  factory DesingationModel.fromJson(Map<String, dynamic> json) {
    return DesingationModel(id: json['id'], designation: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = designation;
    return data;
  }
}
