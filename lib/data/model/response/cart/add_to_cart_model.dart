// To parse this JSON data, do
//
//     final addCartModel = addCartModelFromJson(jsonString);

import 'dart:convert';

AddCartModel addCartModelFromJson(String str) => AddCartModel.fromJson(json.decode(str));

String addCartModelToJson(AddCartModel data) => json.encode(data.toJson());

class AddCartModel {
  AddCartModel({
    this.result,
    this.message,
    this.tempUserId,
    this.userId,
  });

  bool result;
  String message;
  dynamic tempUserId;
  String userId;

  factory AddCartModel.fromJson(Map<String, dynamic> json) => AddCartModel(
    result: json["result"],
    message: json["message"],
    tempUserId: json["temp_user_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "temp_user_id": tempUserId,
    "user_id": userId,
  };
}
