// To parse this JSON data, do
//
//     final connectValidateModels = connectValidateModelsFromJson(jsonString);

import 'dart:convert';

ConnectValidateModels connectValidateModelsFromJson(String str) => ConnectValidateModels.fromJson(json.decode(str));

String connectValidateModelsToJson(ConnectValidateModels data) => json.encode(data.toJson());

class ConnectValidateModels {
    ConnectValidateModels({
        this.code,
        this.message,
        this.success,
        this.detail,
        this.id,
        this.claims,
        this.token,
    });

    String? code;
    String? message;
    bool? success;
    String? detail;
    String? id;
    List<dynamic>? claims;
    String? token;

    factory ConnectValidateModels.fromJson(Map<String, dynamic> json) => ConnectValidateModels(
        code: json["code"],
        message: json["message"],
        success: json["success"],
        detail: json["detail"],
        id: json["id"],
        claims: List<dynamic>.from(json["claims"].map((x) => x)),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "success": success,
        "detail": detail,
        "id": id,
        "claims": List<dynamic>.from(claims!.map((x) => x)),
        "token": token,
    };
}
