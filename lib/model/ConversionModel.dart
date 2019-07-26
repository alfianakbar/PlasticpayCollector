// To parse this JSON data, do
//
//     final conversionModel = conversionModelFromJson(jsonString);

import 'dart:convert';

ConversionModel conversionModelFromJson(String str) => ConversionModel.fromJson(json.decode(str));

String conversionModelToJson(ConversionModel data) => json.encode(data.toJson());

class ConversionModel {
  String status;
  String message;
  int code;
  Content content;

  ConversionModel({
    this.status,
    this.message,
    this.code,
    this.content,
  });

  factory ConversionModel.fromJson(Map<String, dynamic> json) => new ConversionModel(
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
  List<Conversion> conversions;

  Content({
    this.conversions,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
    conversions: new List<Conversion>.from(json["conversions"].map((x) => Conversion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "conversions": new List<dynamic>.from(conversions.map((x) => x.toJson())),
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
