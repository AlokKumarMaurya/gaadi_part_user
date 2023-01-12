// To parse this JSON data, do
//
//     final privacyPolicy = privacyPolicyFromJson(jsonString);

import 'dart:convert';

PrivacyPolicy privacyPolicyFromJson(String str) => PrivacyPolicy.fromJson(json.decode(str));

String privacyPolicyToJson(PrivacyPolicy data) => json.encode(data.toJson());

class PrivacyPolicy {
  PrivacyPolicy({
    this.data,
    this.success,
    this.status,
  });

  List<Datum> data;
  bool success;
  int status;

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
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
    this.content,
  });

  String content;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "content": content,
  };
}
