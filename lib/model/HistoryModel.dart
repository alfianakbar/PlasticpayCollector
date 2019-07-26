// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  String status;
  String message;
  int code;
  Content content;

  HistoryModel({
    this.status,
    this.message,
    this.code,
    this.content,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => new HistoryModel(
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
  List<Transaction> transactions;

  Content({
    this.transactions,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
    transactions: new List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "transactions": new List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class Transaction {
  int id;
  String actorRole;
  int actorId;
  int merchantId;
  String point;
  String status;
  String totalPoint;
  dynamic user;
  Merchant merchant;

  Transaction({
    this.id,
    this.actorRole,
    this.actorId,
    this.merchantId,
    this.point,
    this.status,
    this.totalPoint,
    this.user,
    this.merchant,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => new Transaction(
    id: json["id"],
    actorRole: json["actor_role"],
    actorId: json["actor_id"] == null ? null : json["actor_id"],
    merchantId: json["merchant_id"],
    point: json["point"],
    status: json["status"],
    totalPoint: json["total_point"],
    user: json["user"],
    merchant: Merchant.fromJson(json["merchant"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "actor_role": actorRole,
    "actor_id": actorId == null ? null : actorId,
    "merchant_id": merchantId,
    "point": point,
    "status": status,
    "total_point": totalPoint,
    "user": user,
    "merchant": merchant.toJson(),
  };
}

class Merchant {
  int id;
  String name;
  String email;
  String phoneNumber;
  dynamic gender;
  String address;
  String latitude;
  String longitude;
  int provinceId;
  int regencyId;
  dynamic districtId;
  dynamic villageId;
  String emailInacash;
  String walletInacash;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  DateTime birthDate;
  String pin;

  Merchant({
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
    this.emailInacash,
    this.walletInacash,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.birthDate,
    this.pin,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) => new Merchant(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    gender: json["gender"],
    address: json["address"] == null ? null : json["address"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    regencyId: json["regency_id"] == null ? null : json["regency_id"],
    districtId: json["district_id"],
    villageId: json["village_id"],
    emailInacash: json["email_inacash"],
    walletInacash: json["wallet_inacash"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
    pin: json["pin"] == null ? null : json["pin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "gender": gender,
    "address": address == null ? null : address,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "province_id": provinceId == null ? null : provinceId,
    "regency_id": regencyId == null ? null : regencyId,
    "district_id": districtId,
    "village_id": villageId,
    "email_inacash": emailInacash,
    "wallet_inacash": walletInacash,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "birth_date": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "pin": pin == null ? null : pin,
  };
}
