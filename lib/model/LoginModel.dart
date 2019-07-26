// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) {
  final jsonData = json.decode(str);
  return LoginModel.fromJson(jsonData);
}

String loginModelToJson(LoginModel data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class LoginModel {
  String status;
  String message;
  int code;
  Content content;

  LoginModel({
    this.status,
    this.message,
    this.code,
    this.content,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => new LoginModel(
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
  String token;

  Content({
    this.token,
  });

  factory Content.fromJson(Map<String, dynamic> json) => new Content(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
