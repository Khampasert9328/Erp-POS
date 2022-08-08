import 'dart:convert';

ConnectValidate connectValidateFromJson(String str) => ConnectValidate.fromJson(json.decode(str));

String connectValidateToJson(ConnectValidate data) => json.encode(data.toJson());

class ConnectValidate {
    ConnectValidate({
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

    factory ConnectValidate.fromJson(Map<String, dynamic> json) => ConnectValidate(
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