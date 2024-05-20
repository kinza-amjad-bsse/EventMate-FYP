enum TransactionType {
  deposit,
  withdraw,
  earned,
}

enum TransactionStatus {
  success,
  failed,
  inProcess,
}

class TransactionModel {
  String amount, date, status, type, description;
  String id;

  TransactionModel({
    required this.amount,
    required this.date,
    required this.status,
    required this.type,
    required this.description,
    this.id = "",
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json["amount"],
      date: json["date"],
      status: json["status"],
      description: json["description"],
      type: json["type"],
      id: json["id"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "date": date,
      "status": status,
      "type": type,
      "description": description,
      "id": id,
    };
  }
}
