// To parse this JSON data, do
//
//     final connectTokenModels = connectTokenModelsFromJson(jsonString);

import 'dart:convert';

ConnectTokenModels connectTokenModelsFromJson(String str) => ConnectTokenModels.fromJson(json.decode(str));

String connectTokenModelsToJson(ConnectTokenModels data) => json.encode(data.toJson());

class ConnectTokenModels {
    ConnectTokenModels({
        this.clientId,
        this.secret,
        this.grantType,
        this.scope,
        this.username,
        this.password,
        this.redirectUri,
    });

    String? clientId;
    String? secret;
    String? grantType;
    String? scope;
    String? username;
    String? password;
    String? redirectUri;

    factory ConnectTokenModels.fromJson(Map<String, dynamic> json) => ConnectTokenModels(
        clientId: json["clientID"],
        secret: json["secret"],
        grantType: json["grantType"],
        scope: json["scope"],
        username: json["username"],
        password: json["password"],
        redirectUri: json["redirectUri"],
    );

    Map<String, dynamic> toJson() => {
        "clientID": clientId,
        "secret": secret,
        "grantType": grantType,
        "scope": scope,
        "username": username,
        "password": password,
        "redirectUri": redirectUri,
    };
}
