// To parse this JSON data, do
//
//     final allAddress = allAddressFromJson(jsonString);

import 'dart:convert';

AllAddress allAddressFromJson(String str) => AllAddress.fromJson(json.decode(str));

String allAddressToJson(AllAddress data) => json.encode(data.toJson());

class AllAddress {
  AllAddress({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> data;
  bool success;
  int status;

  factory AllAddress.fromJson(Map<String, dynamic> json) => AllAddress(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.address,
    this.country,
    this.city,
    this.postalCode,
    this.phone,
    this.setDefault,
    this.locationAvailable,
    this.lat,
    this.lang,
    this.deliveryToken,
  });

  int id;
  int userId;
  String address;
  String country;
  String city;
  String postalCode;
  String phone;
  int setDefault;
  bool locationAvailable;
  double lat;
  double lang;
  String deliveryToken;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    address: json["address"],
    country: json["country"],
    city: json["city"],
    postalCode: json["postal_code"],
    phone: json["phone"],
    setDefault: json["set_default"],
    locationAvailable: json["location_available"],
    lat: json["lat"].toDouble(),
    lang: json["lang"].toDouble(),
    deliveryToken: json["delivery_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address": address,
    "country": country,
    "city": city,
    "postal_code": postalCode,
    "phone": phone,
    "set_default": setDefault,
    "location_available": locationAvailable,
    "lat": lat,
    "lang": lang,
    "delivery_token": deliveryToken,
  };
}
