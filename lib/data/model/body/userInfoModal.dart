// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> data;
  bool success;
  int status;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
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
    this.name,
    this.type,
    this.email,
    this.avatar,
    this.avatarOriginal,
    this.address,
    this.city,
    this.country,
    this.postalCode,
    this.phone,
  });

  int id;
  String name;
  String type;
  String email;
  dynamic avatar;
  String avatarOriginal;
  dynamic address;
  dynamic city;
  dynamic country;
  dynamic postalCode;
  String phone;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    email: json["email"],
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
    address: json["address"],
    city: json["city"],
    country: json["country"],
    postalCode: json["postal_code"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "email": email,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "address": address,
    "city": city,
    "country": country,
    "postal_code": postalCode,
    "phone": phone,
  };
}
