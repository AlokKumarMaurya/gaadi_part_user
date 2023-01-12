// To parse this JSON data, do
//
//     final mainBannerModel = mainBannerModelFromJson(jsonString);

import 'dart:convert';

MainBannerModel mainBannerModelFromJson(String str) => MainBannerModel.fromJson(json.decode(str));

String mainBannerModelToJson(MainBannerModel data) => json.encode(data.toJson());

class MainBannerModel {
  MainBannerModel({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> data;
  bool success;
  int status;

  factory MainBannerModel.fromJson(Map<String, dynamic> json) => MainBannerModel(
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
    this.photo,
    this.url,
    this.position,
  });

  String photo;
  String url;
  int position;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    photo: json["photo"],
    url: json["url"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
    "url": url,
    "position": position,
  };
}
