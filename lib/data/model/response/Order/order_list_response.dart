// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

List<OrderListModel> orderListModelFromJson(String str) => List<OrderListModel>.from(json.decode(str).map((x) => OrderListModel.fromJson(x)));

String orderListModelToJson(List<OrderListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderListModel {
  OrderListModel({
    this.id,
    this.customerId,
    this.customerType,
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.transactionRef,
    this.orderAmount,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
    this.discountAmount,
    this.discountType,
    this.couponCode,
    this.shippingMethodId,
    this.shippingCost,
    this.orderGroupId,
    this.verificationCode,
    this.sellerId,
    this.sellerIs,
    this.shippingAddressData,
    this.deliveryManId,
    this.orderNote,
    this.billingAddress,
    this.billingAddressData,
    this.orderType,
    this.extraDiscount,
    this.extraDiscountType,
    this.checked,
    this.shippingType,
    this.deliveryType,
    this.deliveryServiceName,
    this.thirdPartyDeliveryTrackingId,
    this.deliveryMan,
  });

  int id;
  String customerId;
  CustomerType customerType;
  PaymentStatus paymentStatus;
  OrderStatus orderStatus;
  PaymentMethod paymentMethod;
  dynamic transactionRef;
  String orderAmount;
  dynamic shippingAddress;
  DateTime createdAt;
  DateTime updatedAt;
  int discountAmount;
  dynamic discountType;
  String couponCode;
  int shippingMethodId;
  int shippingCost;
  dynamic orderGroupId;
  String verificationCode;
  String sellerId;
  SellerIs sellerIs;
  dynamic shippingAddressData;
  dynamic deliveryManId;
  dynamic orderNote;
  dynamic billingAddress;
  dynamic billingAddressData;
  OrderType orderType;
  int extraDiscount;
  dynamic extraDiscountType;
  String checked;
  dynamic shippingType;
  dynamic deliveryType;
  dynamic deliveryServiceName;
  dynamic thirdPartyDeliveryTrackingId;
  dynamic deliveryMan;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    id: json["id"] == null ? null : json["id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    customerType: json["customer_type"] == null ? null : customerTypeValues.map[json["customer_type"]],
    paymentStatus: json["payment_status"] == null ? null : paymentStatusValues.map[json["payment_status"]],
    orderStatus: json["order_status"] == null ? null : orderStatusValues.map[json["order_status"]],
    paymentMethod: json["payment_method"] == null ? null : paymentMethodValues.map[json["payment_method"]],
    transactionRef: json["transaction_ref"],
    orderAmount: json["order_amount"] == null ? null : json["order_amount"],
    shippingAddress: json["shipping_address"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    discountAmount: json["discount_amount"] == null ? null : json["discount_amount"],
    discountType: json["discount_type"],
    couponCode: json["coupon_code"] == null ? null : json["coupon_code"],
    shippingMethodId: json["shipping_method_id"] == null ? null : json["shipping_method_id"],
    shippingCost: json["shipping_cost"] == null ? null : json["shipping_cost"],
    orderGroupId: json["order_group_id"],
    verificationCode: json["verification_code"] == null ? null : json["verification_code"],
    sellerId: json["seller_id"] == null ? null : json["seller_id"],
    sellerIs: json["seller_is"] == null ? null : sellerIsValues.map[json["seller_is"]],
    shippingAddressData: json["shipping_address_data"],
    deliveryManId: json["delivery_man_id"],
    orderNote: json["order_note"],
    billingAddress: json["billing_address"],
    billingAddressData: json["billing_address_data"],
    orderType: json["order_type"] == null ? null : orderTypeValues.map[json["order_type"]],
    extraDiscount: json["extra_discount"] == null ? null : json["extra_discount"],
    extraDiscountType: json["extra_discount_type"],
    checked: json["checked"] == null ? null : json["checked"],
    shippingType: json["shipping_type"],
    deliveryType: json["delivery_type"],
    deliveryServiceName: json["delivery_service_name"],
    thirdPartyDeliveryTrackingId: json["third_party_delivery_tracking_id"],
    deliveryMan: json["delivery_man"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "customer_id": customerId == null ? null : customerId,
    "customer_type": customerType == null ? null : customerTypeValues.reverse[customerType],
    "payment_status": paymentStatus == null ? null : paymentStatusValues.reverse[paymentStatus],
    "order_status": orderStatus == null ? null : orderStatusValues.reverse[orderStatus],
    "payment_method": paymentMethod == null ? null : paymentMethodValues.reverse[paymentMethod],
    "transaction_ref": transactionRef,
    "order_amount": orderAmount == null ? null : orderAmount,
    "shipping_address": shippingAddress,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "discount_amount": discountAmount == null ? null : discountAmount,
    "discount_type": discountType,
    "coupon_code": couponCode == null ? null : couponCode,
    "shipping_method_id": shippingMethodId == null ? null : shippingMethodId,
    "shipping_cost": shippingCost == null ? null : shippingCost,
    "order_group_id": orderGroupId,
    "verification_code": verificationCode == null ? null : verificationCode,
    "seller_id": sellerId == null ? null : sellerId,
    "seller_is": sellerIs == null ? null : sellerIsValues.reverse[sellerIs],
    "shipping_address_data": shippingAddressData,
    "delivery_man_id": deliveryManId,
    "order_note": orderNote,
    "billing_address": billingAddress,
    "billing_address_data": billingAddressData,
    "order_type": orderType == null ? null : orderTypeValues.reverse[orderType],
    "extra_discount": extraDiscount == null ? null : extraDiscount,
    "extra_discount_type": extraDiscountType,
    "checked": checked == null ? null : checked,
    "shipping_type": shippingType,
    "delivery_type": deliveryType,
    "delivery_service_name": deliveryServiceName,
    "third_party_delivery_tracking_id": thirdPartyDeliveryTrackingId,
    "delivery_man": deliveryMan,
  };
}

enum CustomerType { SELLER }

final customerTypeValues = EnumValues({
  "seller": CustomerType.SELLER
});

enum OrderStatus { PENDING }

final orderStatusValues = EnumValues({
  "pending": OrderStatus.PENDING
});

enum OrderType { POS }

final orderTypeValues = EnumValues({
  "POS": OrderType.POS
});

enum PaymentMethod { RAZORPAY, CASH_ON_DELIVERY }

final paymentMethodValues = EnumValues({
  "cash_on_delivery": PaymentMethod.CASH_ON_DELIVERY,
  "razorpay": PaymentMethod.RAZORPAY
});

enum PaymentStatus { UNPAID }

final paymentStatusValues = EnumValues({
  "unpaid": PaymentStatus.UNPAID
});

enum SellerIs { ADMIN }

final sellerIsValues = EnumValues({
  "admin": SellerIs.ADMIN
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
