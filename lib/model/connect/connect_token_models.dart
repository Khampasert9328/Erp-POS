// To parse this JSON data, do
//
//     final connectTokenModels = connectTokenModelsFromJson(jsonString);

import 'dart:convert';

ConnectTokenModels connectTokenModelsFromJson(String str) => ConnectTokenModels.fromJson(json.decode(str));

String connectTokenModelsToJson(ConnectTokenModels data) => json.encode(data.toJson());

class ConnectTokenModels {
    ConnectTokenModels({
        this.code,
        this.message,
        this.isSuccess,
        this.content,
    });

    String? code;
    String? message;
    bool? isSuccess;
    Content? content;

    factory ConnectTokenModels.fromJson(Map<String, dynamic> json) => ConnectTokenModels(
        code: json["code"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        content: Content.fromJson(json["content"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "isSuccess": isSuccess,
        "content": content!.toJson(),
    };
}

class Content {
    Content({
        this.accessToken,
        this.expire,
        this.refreshToken,
        this.success,
        this.code,
        this.message,
    });

    String? accessToken;
    int? expire;
    String? refreshToken;
    bool? success;
    String? code;
    String? message;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        accessToken: json["accessToken"],
        expire: json["expire"],
        refreshToken: json["refreshToken"],
        success: json["success"],
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "expire": expire,
        "refreshToken": refreshToken,
        "success": success,
        "code": code,
        "message": message,
    };
}
