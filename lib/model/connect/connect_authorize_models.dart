// To parse this JSON data, do
//
//     final connectAuthorizeModels = connectAuthorizeModelsFromJson(jsonString);

import 'dart:convert';

ConnectAuthorizeModels connectAuthorizeModelsFromJson(String str) => ConnectAuthorizeModels.fromJson(json.decode(str));

String connectAuthorizeModelsToJson(ConnectAuthorizeModels data) => json.encode(data.toJson());

class ConnectAuthorizeModels {
    ConnectAuthorizeModels({
        this.email,
        this.logon,
        this.name,
        this.tennantId,
        this.postype,
        this.roleType,
    });

    String? email;
    String? logon;
    String? name;
    String? tennantId;
    String? postype;
    String? roleType;

    factory ConnectAuthorizeModels.fromJson(Map<String, dynamic> json) => ConnectAuthorizeModels(
        email: json["email"],
        logon: json["logon"],
        name: json["name"],
        tennantId: json["tennantId"],
        postype: json["postype"],
        roleType: json["roleType"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "logon": logon,
        "name": name,
        "tennantId": tennantId,
        "postype": postype,
        "roleType": roleType,
    };
}
