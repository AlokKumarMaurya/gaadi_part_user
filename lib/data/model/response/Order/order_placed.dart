// To parse this JSON data, do
//
//     final orderPlaced = orderPlacedFromJson(jsonString);

import 'dart:convert';

OrderPlaced orderPlacedFromJson(String str) => OrderPlaced.fromJson(json.decode(str));

String orderPlacedToJson(OrderPlaced data) => json.encode(data.toJson());

class OrderPlaced {
  OrderPlaced({
    this.result,
    this.message,
    this.orderId,
  });

  bool result;
  String message;
  int orderId;

  factory OrderPlaced.fromJson(Map<String, dynamic> json) => OrderPlaced(
    result: json["result"],
    message: json["message"],
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "order_id": orderId,
  };
}
