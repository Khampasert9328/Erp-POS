// To parse this JSON data, do
//
//     final areaModels = areaModelsFromJson(jsonString);

import 'dart:convert';

AreaModels areaModelsFromJson(String str) => AreaModels.fromJson(json.decode(str));

String areaModelsToJson(AreaModels data) => json.encode(data.toJson());

class AreaModels {
    AreaModels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.area,
        this.totalcount,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<Area>? area;
    int? totalcount;

    factory AreaModels.fromJson(Map<String, dynamic> json) => AreaModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        area: List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
        totalcount: json["totalcount"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "area": List<dynamic>.from(area!.map((x) => x.toJson())),
        "totalcount": totalcount,
    };
}

class Area {
    Area({
        this.id,
        this.area,
        this.status,
        this.seleted,
    });

    String? id;
    String? area;
    int? status;
    bool? seleted;

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        area: json["area"],
        status: json["status"],
        seleted: json["seleted"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
        "status": status,
        "seleted": seleted,
    };
}
