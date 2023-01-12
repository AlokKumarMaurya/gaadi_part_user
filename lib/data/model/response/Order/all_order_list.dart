// To parse this JSON data, do
//
//     final allOrderList = allOrderListFromJson(jsonString);

import 'dart:convert';

AllOrderList allOrderListFromJson(String str) => AllOrderList.fromJson(json.decode(str));

String allOrderListToJson(AllOrderList data) => json.encode(data.toJson());

class AllOrderList {
  AllOrderList({
    this.order,
    this.result,
    this.message,
  });

  List<Order> order;
  bool result;
  String message;

  factory AllOrderList.fromJson(Map<String, dynamic> json) => AllOrderList(
    order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
    result: json["result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "order": List<dynamic>.from(order.map((x) => x.toJson())),
    "result": result,
    "message": message,
  };
}

class Order {
  Order({
    this.id,
    this.userId,
    this.guestId,
    this.sellerId,
    this.shippingAddress,
    this.deliveryStatus,
    this.paymentType,
    this.paymentStatus,
    this.paymentDetails,
    this.grandTotal,
    this.couponDiscount,
    this.code,
    this.date,
    this.viewed,
    this.deliveryViewed,
    this.paymentStatusViewed,
    this.commissionCalculated,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String userId;
  dynamic guestId;
  String sellerId;
  String shippingAddress;
  DeliveryStatus deliveryStatus;
  PaymentType paymentType;
  PaymentStatus paymentStatus;
  dynamic paymentDetails;
  String grandTotal;
  String couponDiscount;
  String code;
  String date;
  String viewed;
  String deliveryViewed;
  String paymentStatusViewed;
  String commissionCalculated;
  DateTime createdAt;
  DateTime updatedAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    guestId: json["guest_id"],
    sellerId: json["seller_id"],
    shippingAddress: json["shipping_address"] == null ? null : json["shipping_address"],
    deliveryStatus: deliveryStatusValues.map[json["delivery_status"]],
    paymentType: json["payment_type"] == null ? null : paymentTypeValues.map[json["payment_type"]],
    paymentStatus: paymentStatusValues.map[json["payment_status"]],
    paymentDetails: json["payment_details"],
    grandTotal: json["grand_total"] == null ? null : json["grand_total"],
    couponDiscount: json["coupon_discount"],
    code: json["code"] == null ? null : json["code"],
    date: json["date"],
    viewed: json["viewed"],
    deliveryViewed: json["delivery_viewed"],
    paymentStatusViewed: json["payment_status_viewed"],
    commissionCalculated: json["commission_calculated"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "guest_id": guestId,
    "seller_id": sellerId,
    "shipping_address": shippingAddress == null ? null : shippingAddress,
    "delivery_status": deliveryStatusValues.reverse[deliveryStatus],
    "payment_type": paymentType == null ? null : paymentTypeValues.reverse[paymentType],
    "payment_status": paymentStatusValues.reverse[paymentStatus],
    "payment_details": paymentDetails,
    "grand_total": grandTotal == null ? null : grandTotal,
    "coupon_discount": couponDiscount,
    "code": code == null ? null : code,
    "date": date,
    "viewed": viewed,
    "delivery_viewed": deliveryViewed,
    "payment_status_viewed": paymentStatusViewed,
    "commission_calculated": commissionCalculated,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

enum DeliveryStatus { PENDING }

final deliveryStatusValues = EnumValues({
  "pending": DeliveryStatus.PENDING
});

enum PaymentStatus { UNPAID }

final paymentStatusValues = EnumValues({
  "unpaid": PaymentStatus.UNPAID
});

enum PaymentType { RAZORPAY, CASH_ON_DELIVERY }

final paymentTypeValues = EnumValues({
  "cash_on_delivery": PaymentType.CASH_ON_DELIVERY,
  "razorpay": PaymentType.RAZORPAY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
