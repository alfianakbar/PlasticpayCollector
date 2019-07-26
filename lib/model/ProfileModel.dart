// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String status;
  String message;
  int code;
  Content content;

  ProfileModel({
    this.status,
    this.message,
    this.code,
    this.content,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => new ProfileModel(
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
  User user;

  Content({
    this.user,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  int id;
  String name;
  String email;
  String phoneNumber;
  String gender;
  String address;
  dynamic latitude;
  dynamic longitude;
  int provinceId;
  int regencyId;
  dynamic districtId;
  dynamic villageId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.address,
    this.latitude,
    this.longitude,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.villageId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    gender: json["gender"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
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
    "latitude": latitude,
    "longitude": longitude,
    "province_id": provinceId,
    "regency_id": regencyId,
    "district_id": districtId,
    "village_id": villageId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
