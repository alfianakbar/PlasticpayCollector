// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  String status;
  String message;
  int code;
  Content content;

  TransactionModel({
    this.status,
    this.message,
    this.code,
    this.content,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      new TransactionModel(
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
  List<Transaction> transactions;
  List<Conversion> conversions;

  Content({
    this.transactions,
    this.conversions,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
        transactions: new List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
        conversions: new List<Conversion>.from(
            json["conversions"].map((x) => Conversion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactions":
            new List<dynamic>.from(transactions.map((x) => x.toJson())),
        "conversions":
            new List<dynamic>.from(conversions.map((x) => x.toJson())),
      };
}

class Conversion {
  int id;
  String plasticName;
  String weight;

  Conversion({
    this.id,
    this.plasticName,
    this.weight,
  });

  factory Conversion.fromJson(Map<String, dynamic> json) => new Conversion(
        id: json["id"],
        plasticName: json["plastic_name"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plastic_name": plasticName,
        "weight": weight,
      };
}

class Transaction {
  int id;
  int userId;
  int plasticCollectorId;
  int status;
  DateTime createdAt;
  User user;
  PlasticCollector plasticCollector;

  Transaction({
    this.id,
    this.userId,
    this.plasticCollectorId,
    this.status,
    this.createdAt,
    this.user,
    this.plasticCollector,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => new Transaction(
        id: json["id"],
        userId: json["user_id"],
        plasticCollectorId: json["plastic_collector_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        user: User.fromJson(json["user"]),
        plasticCollector: PlasticCollector.fromJson(json["plastic_collector"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "plastic_collector_id": plasticCollectorId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "user": user.toJson(),
        "plastic_collector": plasticCollector.toJson(),
      };
}

class PlasticCollector {
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
  String capacity;
  String emailInacash;
  String walletInacash;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  PlasticCollector({
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
    this.capacity,
    this.emailInacash,
    this.walletInacash,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory PlasticCollector.fromJson(Map<String, dynamic> json) =>
      new PlasticCollector(
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
        capacity: json["capacity"],
        emailInacash: json["email_inacash"],
        walletInacash: json["wallet_inacash"],
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
        "capacity": capacity,
        "email_inacash": emailInacash,
        "wallet_inacash": walletInacash,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class User {
  int id;
  String name;
  String email;
  String phoneNumber;
  dynamic gender;
  DateTime birthDate;
  dynamic address;
  dynamic provinceId;
  dynamic regencyId;
  String pin;
  String emailInacash;
  String walletInacash;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

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
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        birthDate: DateTime.parse(json["birth_date"]),
        address: json["address"],
        provinceId: json["province_id"],
        regencyId: json["regency_id"],
        pin: json["pin"],
        emailInacash: json["email_inacash"],
        walletInacash: json["wallet_inacash"],
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
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "address": address,
        "province_id": provinceId,
        "regency_id": regencyId,
        "pin": pin,
        "email_inacash": emailInacash,
        "wallet_inacash": walletInacash,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
