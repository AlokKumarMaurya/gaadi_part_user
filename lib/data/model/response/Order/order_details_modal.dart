// To parse this JSON data, do
//
//     final getOrderDetails = getOrderDetailsFromJson(jsonString);

import 'dart:convert';

GetOrderDetails getOrderDetailsFromJson(String str) => GetOrderDetails.fromJson(json.decode(str));

String getOrderDetailsToJson(GetOrderDetails data) => json.encode(data.toJson());

class GetOrderDetails {
  GetOrderDetails({
    this.orderId,
    this.userId,
    this.sellerId,
    this.shippingAddress,
    this.deliveryStatus,
    this.paymentType,
    this.paymentStatus,
    this.grandTotal,
    this.orderDetails,
  });

  int orderId;
  String userId;
  String sellerId;
  ShippingAddress shippingAddress;
  String deliveryStatus;
  String paymentType;
  String paymentStatus;
  dynamic grandTotal;
  OrderDetails orderDetails;

  factory GetOrderDetails.fromJson(Map<String, dynamic> json) => GetOrderDetails(
    orderId: json["order_id"],
    userId: json["user_id"],
    sellerId: json["seller_id"],
    shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
    deliveryStatus: json["delivery_status"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    grandTotal: json["grand_total"],
    orderDetails: OrderDetails.fromJson(json["order_details"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "user_id": userId,
    "seller_id": sellerId,
    "shipping_address": shippingAddress.toJson(),
    "delivery_status": deliveryStatus,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "grand_total": grandTotal,
    "order_details": orderDetails.toJson(),
  };
}

class OrderDetails {
  OrderDetails({
    this.productId,
    this.productName,
    this.unitPrice,
  });

  int productId;
  String productName;
  String unitPrice;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    productId: json["product_id"],
    productName: json["product_name"],
    unitPrice: json["unit_price"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_name": productName,
    "unit_price": unitPrice,
  };
}

class ShippingAddress {
  ShippingAddress({
    this.id,
    this.userId,
    this.address,
    this.country,
    this.city,
    this.longitude,
    this.latitude,
    this.postalCode,
    this.phone,
    this.setDefault,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
  });

  int id;
  String userId;
  String address;
  String country;
  String city;
  dynamic longitude;
  dynamic latitude;
  String postalCode;
  String phone;
  String setDefault;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String email;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    postalCode: json["postal_code"],
    phone: json["phone"],
    setDefault: json["set_default"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "country": country,
    "city": city,
    "longitude": longitude,
    "latitude": latitude,
    "postal_code": postalCode,
    "phone": phone,
    "set_default": setDefault,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "email": email,
  };
}
