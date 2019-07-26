// To parse this JSON data, do
//
//     final collectorModel = collectorModelFromJson(jsonString);

import 'dart:convert';

CollectorModel collectorModelFromJson(String str) => CollectorModel.fromJson(json.decode(str));

String collectorModelToJson(CollectorModel data) => json.encode(data.toJson());

class CollectorModel {
  String status;
  String message;
  int code;
  Content content;

  CollectorModel({
    this.status,
    this.message,
    this.code,
    this.content,
  });

  factory CollectorModel.fromJson(Map<String, dynamic> json) => new CollectorModel(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    content: Content.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "content": content.toJson(),
  };
}

class Content {
  Collector collector;

  Content({
    this.collector,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
    collector: Collector.fromJson(json["collector"]),
  );

  Map<String, dynamic> toJson() => {
    "collector": collector.toJson(),
  };
}

class Collector {
  int id;
  String name;
  String email;
  String phoneNumber;
  String gender;
  String address;
  int provinceId;
  int regencyId;
  dynamic districtId;
  dynamic villageId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Collector({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.address,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Collector.fromJson(Map<String, dynamic> json) => new Collector(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    gender: json["gender"],
    address: json["address"],
    provinceId: json["province_id"],
    regencyId: json["regency_id"],
    districtId: json["district_id"],
    villageId: json["village_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "gender": gender,
    "address": address,
    "province_id": provinceId,
    "regency_id": regencyId,
    "district_id": districtId,
    "village_id": villageId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
