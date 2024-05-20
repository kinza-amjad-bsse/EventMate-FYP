enum OrderStatus {
  pending,
  processing,
  completed,
  cancelled,
}

class OrdersModel {
  String id, date, status, amount, title, image;
  String placedBy, placedTo, deadline;

  OrdersModel({
    required this.id,
    required this.date,
    required this.status,
    required this.amount,
    required this.title,
    required this.image,
    required this.placedBy,
    required this.placedTo,
    required this.deadline,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      id: json["id"],
      date: json["date"],
      status: json["status"],
      amount: json["amount"],
      title: json["title"],
      image: json["image"],
      placedBy: json["placed_by"],
      placedTo: json["placed_to"],
      deadline: json["deadline"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date,
      "status": status,
      "amount": amount,
      "title": title,
      "image": image,
      "placed_by": placedBy,
      "placed_to": placedTo,
      "deadline": deadline,
    };
  }
}
