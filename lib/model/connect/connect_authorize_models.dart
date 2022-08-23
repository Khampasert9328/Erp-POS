// To parse this JSON data, do
//
//     final connectAuthorizeModels = connectAuthorizeModelsFromJson(jsonString);

import 'dart:convert';

ConnectAuthorizeModels connectAuthorizeModelsFromJson(String str) => ConnectAuthorizeModels.fromJson(json.decode(str));

String connectAuthorizeModelsToJson(ConnectAuthorizeModels data) => json.encode(data.toJson());

class ConnectAuthorizeModels {
    ConnectAuthorizeModels({
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

    factory ConnectAuthorizeModels.fromJson(Map<String, dynamic> json) => ConnectAuthorizeModels(
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
