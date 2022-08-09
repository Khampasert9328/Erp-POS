// To parse this JSON data, do
//
//     final connectCreateTenantModels = connectCreateTenantModelsFromJson(jsonString);

import 'dart:convert';

ConnectCreateTenantModels connectCreateTenantModelsFromJson(String str) => ConnectCreateTenantModels.fromJson(json.decode(str));

String connectCreateTenantModelsToJson(ConnectCreateTenantModels data) => json.encode(data.toJson());

class ConnectCreateTenantModels {
    ConnectCreateTenantModels({
        this.id,
        this.name,
        this.firstname,
        this.lastname,
        this.country,
        this.province,
        this.district,
        this.village,
        this.address,
        this.contact,
        this.status,
    });

    String? id;
    String? name;
    String? firstname;
    String? lastname;
    String? country;
    String? province;
    String? district;
    String? village;
    String? address;
    String? contact;
    String? status;

    factory ConnectCreateTenantModels.fromJson(Map<String, dynamic> json) => ConnectCreateTenantModels(
        id: json["id"],
        name: json["name"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        country: json["country"],
        province: json["province"],
        district: json["district"],
        village: json["village"],
        address: json["address"],
        contact: json["contact"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstname": firstname,
        "lastname": lastname,
        "country": country,
        "province": province,
        "district": district,
        "village": village,
        "address": address,
        "contact": contact,
        "status": status,
    };
}
