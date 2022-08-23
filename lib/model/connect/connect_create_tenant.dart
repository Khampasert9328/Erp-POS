// To parse this JSON data, do
//
//     final connectCreateTenantModels = connectCreateTenantModelsFromJson(jsonString);

import 'dart:convert';

ConnectCreateTenantModels connectCreateTenantModelsFromJson(String str) => ConnectCreateTenantModels.fromJson(json.decode(str));

String connectCreateTenantModelsToJson(ConnectCreateTenantModels data) => json.encode(data.toJson());

class ConnectCreateTenantModels {
    ConnectCreateTenantModels({
        this.issucess,
        this.error,
        this.id,
        this.code,
    });

    bool? issucess;
    String? error;
    String? id;
    String? code;

    factory ConnectCreateTenantModels.fromJson(Map<String, dynamic> json) => ConnectCreateTenantModels(
        issucess: json["issucess"],
        error: json["error"],
        id: json["id"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "issucess": issucess,
        "error": error,
        "id": id,
        "code": code,
    };
}
