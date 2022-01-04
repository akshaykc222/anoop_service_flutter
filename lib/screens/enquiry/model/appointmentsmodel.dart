class AppointMentModel {
  AppointMentModel({
    this.id,
    this.createdUser,
    required this.bookingDate,
    required this.proposedFee,
    required this.customerFee,
    required this.amountPaid,
    required this.dueAmount,

    required this.reminderDate,
    required this.notes,
     this.createdDate,
    this.status,
    required this.customer,
    this.refferdBy,
    required this.initialConsultant,
    required this.mainConsultant,
  });

  int? id;
  int? createdUser;
  DateTime bookingDate;
  double proposedFee;
  double customerFee;
  double amountPaid;
  double dueAmount;

  DateTime reminderDate;
  String notes;
  DateTime? createdDate;
  int customer;
  String? status;
  int? refferdBy;
  int initialConsultant;
  int mainConsultant;

  factory AppointMentModel.fromJson(Map<String, dynamic> json) =>
      AppointMentModel(
        id: json["id"],
        createdUser: json["created_user"],
        bookingDate: DateTime.parse(json["booking_date"]),
        proposedFee: json["proposed_fee"].toDouble(),
        customerFee: json["customer_fee"].toDouble(),
        amountPaid: json["amount_paid"].toDouble(),
        dueAmount: json["due_amount"].toDouble(),
        status: json['status'],
        reminderDate: DateTime.parse(json["reminder_date"]),
        notes: json["notes"],
        createdDate: DateTime.parse(json["created_date"]),
        customer: json["customer"],
        refferdBy: json["refferd_by"],
        initialConsultant: json["initial_consultant"],
        mainConsultant: json["main_consultant"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_user": createdUser,
        "booking_date":
            "${bookingDate.year.toString().padLeft(4, '0')}-${bookingDate.month.toString().padLeft(2, '0')}-${bookingDate.day.toString().padLeft(2, '0')}",
        "proposed_fee": proposedFee,
        "customer_fee": customerFee,
        "amount_paid": amountPaid,
        "due_amount": dueAmount,
        "status":status,
         "reminder_date":
            "${reminderDate.year.toString().padLeft(4, '0')}-${reminderDate.month.toString().padLeft(2, '0')}-${reminderDate.day.toString().padLeft(2, '0')}",
        "notes": notes,
        "created_date": null,
        "customer": customer,
        "refferd_by": refferdBy,
        "initial_consultant": initialConsultant,
        "main_consultant": mainConsultant,
      };
}
