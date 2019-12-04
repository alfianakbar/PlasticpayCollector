// To parse this JSON data, do
//
//     final redeemModel = redeemModelFromJson(jsonString);

import 'dart:convert';

RedeemModel redeemModelFromJson(String str) => RedeemModel.fromJson(json.decode(str));

String redeemModelToJson(RedeemModel data) => json.encode(data.toJson());

class RedeemModel {
  String status;
  String message;
  int code;
  Content content;

  RedeemModel({
    this.status,
    this.message,
    this.code,
    this.content,
  });

  factory RedeemModel.fromJson(Map<String, dynamic> json) => new RedeemModel(
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
  Transaction transaction;

  Content({
    this.transaction,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
    transaction: Transaction.fromJson(json["transaction"]),
  );

  Map<String, dynamic> toJson() => {
    "transaction": transaction.toJson(),
  };
}

class Transaction {
  String actorRole;
  int actorId;
  int totalPoint;
  int totalMoney;
  DateTime createdAt;
  int id;

  Transaction({
    this.actorRole,
    this.actorId,
    this.totalPoint,
    this.totalMoney,
    this.createdAt,
    this.id,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => new Transaction(
    actorRole: json["actor_role"],
    actorId: json["actor_id"],
    totalPoint: json["total_point"],
    totalMoney: json["total_money"],
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "actor_role": actorRole,
    "actor_id": actorId,
    "total_point": totalPoint,
    "total_money": totalMoney,
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
