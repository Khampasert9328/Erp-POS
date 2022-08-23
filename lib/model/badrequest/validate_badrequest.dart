
import 'dart:convert';

ConnectValidatModelBadRequest connectValidatModelBadRequestFromJson(String str) => ConnectValidatModelBadRequest.fromJson(json.decode(str));

String connectValidatModelBadRequestToJson(ConnectValidatModelBadRequest data) => json.encode(data.toJson());

class ConnectValidatModelBadRequest {
    ConnectValidatModelBadRequest({
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
    List<Claim>? claims;
    String? token;

    factory ConnectValidatModelBadRequest.fromJson(Map<String, dynamic> json) => ConnectValidatModelBadRequest(
        code: json["code"],
        message: json["message"],
        success: json["success"],
        detail: json["detail"],
        id: json["id"],
        claims: List<Claim>.from(json["claims"].map((x) => Claim.fromJson(x))),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "success": success,
        "detail": detail,
        "id": id,
        "claims": List<dynamic>.from(claims!.map((x) => x.toJson())),
        "token": token,
    };
}

class Claim {
    Claim({
        this.name,
        this.value,
    });

    String? name;
    String? value;

    factory Claim.fromJson(Map<String, dynamic> json) => Claim(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}
