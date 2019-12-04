// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

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
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
  dynamic gender;
  DateTime birthDate;
  String address;
  int provinceId;
  int regencyId;
  String pin;
  String emailInacash;
  String walletInacash;
  DateTime createdAt;
  CurrentStatus currentStatus;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.birthDate,
    this.address,
    this.provinceId,
    this.regencyId,
    this.pin,
    this.emailInacash,
    this.walletInacash,
    this.createdAt,
    this.currentStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        address: json["address"],
        provinceId: json["province_id"],
        regencyId: json["regency_id"],
        pin: json["pin"],
        emailInacash: json["email_inacash"],
        walletInacash: json["wallet_inacash"],
        createdAt: DateTime.parse(json["created_at"]),
        currentStatus: json["currentStatus"] == null
            ? null
            : CurrentStatus.fromJson(json["currentStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "gender": gender,
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "address": address,
        "province_id": provinceId,
        "regency_id": regencyId,
        "pin": pin,
        "email_inacash": emailInacash,
        "wallet_inacash": walletInacash,
        "created_at": createdAt.toIso8601String(),
        "currentStatus": currentStatus.toJson(),
      };
}

class CurrentStatus {
  int id;
  int userId;
  String actorRole;
  int actorId;
  int transactionId;
  String point;
  String status;
  String totalPoint;
  DateTime createdAt;

  CurrentStatus({
    this.id,
    this.userId,
    this.actorRole,
    this.actorId,
    this.transactionId,
    this.point,
    this.status,
    this.totalPoint,
    this.createdAt,
  });

  factory CurrentStatus.fromJson(Map<String, dynamic> json) =>
      new CurrentStatus(
        id: json["id"],
        userId: json["user_id"],
        actorRole: json["actor_role"],
        actorId: json["actor_id"],
        transactionId: json["transaction_id"],
        point: json["point"],
        status: json["status"],
        totalPoint: json["total_point"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "actor_role": actorRole,
        "actor_id": actorId,
        "transaction_id": transactionId,
        "point": point,
        "status": status,
        "total_point": totalPoint,
        "created_at": createdAt.toIso8601String(),
      };
}
