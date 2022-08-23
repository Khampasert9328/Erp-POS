// To parse this JSON data, do
//
//     final getTableModels = getTableModelsFromJson(jsonString);

import 'dart:convert';

GetTableModels getTableModelsFromJson(String str) => GetTableModels.fromJson(json.decode(str));

String getTableModelsToJson(GetTableModels data) => json.encode(data.toJson());

class GetTableModels {
    GetTableModels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.table,
        this.totalcount,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<GetTable>? table;
    int? totalcount;

    factory GetTableModels.fromJson(Map<String, dynamic> json) => GetTableModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        table: List<GetTable>.from(json["table"].map((x) => GetTable.fromJson(x))),
        totalcount: json["totalcount"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "table": List<dynamic>.from(table!.map((x) => x.toJson())),
        "totalcount": totalcount,
    };
}

class GetTable {
    GetTable({
        this.id,
        this.name,
        this.status,
        this.statusAv,
        this.tablemerge,
        this.tablearea,
        this.selected,
    });

    String? id;
    String? name;
    int? status;
    int? statusAv;
    Tablemerge? tablemerge;
    Tablearea? tablearea;
    bool? selected;

    factory GetTable.fromJson(Map<String, dynamic> json) => GetTable(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        statusAv: json["status_av"],
        tablemerge: Tablemerge.fromJson(json["tablemerge"]),
        tablearea: Tablearea.fromJson(json["tablearea"]),
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "status_av": statusAv,
        "tablemerge": tablemerge!.toJson(),
        "tablearea": tablearea!.toJson(),
        "selected": selected,
    };
}

class Tablearea {
    Tablearea({
        this.id,
        this.area,
    });

    String? id;
    String? area;

    factory Tablearea.fromJson(Map<String, dynamic> json) => Tablearea(
        id: json["id"],
        area: json["area"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
    };
}

class Tablemerge {
    Tablemerge({
        this.tableid,
        this.tablename,
    });

    String? tableid;
    String? tablename;

    factory Tablemerge.fromJson(Map<String, dynamic> json) => Tablemerge(
        tableid: json["tableid"],
        tablename: json["tablename"],
    );

    Map<String, dynamic> toJson() => {
        "tableid": tableid,
        "tablename": tablename,
    };
}
