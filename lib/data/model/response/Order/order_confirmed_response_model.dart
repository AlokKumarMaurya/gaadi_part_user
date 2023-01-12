// To parse this JSON data, do
//
//     final orderConfirmedModel = orderConfirmedModelFromJson(jsonString);

import 'dart:convert';

OrderConfirmedModel orderConfirmedModelFromJson(String str) => OrderConfirmedModel.fromJson(json.decode(str));

String orderConfirmedModelToJson(OrderConfirmedModel data) => json.encode(data.toJson());

class OrderConfirmedModel {
  OrderConfirmedModel({
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
  dynamic shippingAddress;
  String deliveryStatus;
  String paymentType;
  String paymentStatus;
  dynamic paymentDetails;
  dynamic grandTotal;
  String couponDiscount;
  dynamic code;
  String date;
  String viewed;
  String deliveryViewed;
  String paymentStatusViewed;
  String commissionCalculated;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderConfirmedModel.fromJson(Map<String, dynamic> json) => OrderConfirmedModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    guestId: json["guest_id"],
    sellerId: json["seller_id"] == null ? null : json["seller_id"],
    shippingAddress: json["shipping_address"],
    deliveryStatus: json["delivery_status"] == null ? null : json["delivery_status"],
    paymentType: json["payment_type"] == null ? null : json["payment_type"],
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    paymentDetails: json["payment_details"],
    grandTotal: json["grand_total"],
    couponDiscount: json["coupon_discount"] == null ? null : json["coupon_discount"],
    code: json["code"],
    date: json["date"] == null ? null : json["date"],
    viewed: json["viewed"] == null ? null : json["viewed"],
    deliveryViewed: json["delivery_viewed"] == null ? null : json["delivery_viewed"],
    paymentStatusViewed: json["payment_status_viewed"] == null ? null : json["payment_status_viewed"],
    commissionCalculated: json["commission_calculated"] == null ? null : json["commission_calculated"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "guest_id": guestId,
    "seller_id": sellerId == null ? null : sellerId,
    "shipping_address": shippingAddress,
    "delivery_status": deliveryStatus == null ? null : deliveryStatus,
    "payment_type": paymentType == null ? null : paymentType,
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "payment_details": paymentDetails,
    "grand_total": grandTotal,
    "coupon_discount": couponDiscount == null ? null : couponDiscount,
    "code": code,
    "date": date == null ? null : date,
    "viewed": viewed == null ? null : viewed,
    "delivery_viewed": deliveryViewed == null ? null : deliveryViewed,
    "payment_status_viewed": paymentStatusViewed == null ? null : paymentStatusViewed,
    "commission_calculated": commissionCalculated == null ? null : commissionCalculated,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
