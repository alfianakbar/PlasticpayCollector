// To parse this JSON data, do
//
//     final pinModel = pinModelFromJson(jsonString);

import 'dart:convert';

PinModel pinModelFromJson(String str) => PinModel.fromJson(json.decode(str));

String pinModelToJson(PinModel data) => json.encode(data.toJson());

class PinModel {
  String status;
  String message;
  int code;

  PinModel({
    this.status,
    this.message,
    this.code,
  });

  factory PinModel.fromJson(Map<String, dynamic> json) => new PinModel(
    status: json["status"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
  };
}
