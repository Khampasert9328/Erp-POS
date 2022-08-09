
import 'dart:convert';

ConnectValidateModels connectValidateModelsFromJson(String str) => ConnectValidateModels.fromJson(json.decode(str));

String connectValidateModelsToJson(ConnectValidateModels data) => json.encode(data.toJson());

class ConnectValidateModels {
    ConnectValidateModels({
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

    factory ConnectValidateModels.fromJson(Map<String, dynamic> json) => ConnectValidateModels(
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
