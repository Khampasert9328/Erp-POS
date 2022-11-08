// To parse this JSON data, do
//
//     final getTableAll = getTableAllFromJson(jsonString);

import 'dart:convert';

GetTableAll getTableAllFromJson(String str) => GetTableAll.fromJson(json.decode(str));

String getTableAllToJson(GetTableAll data) => json.encode(data.toJson());

class GetTableAll {
    GetTableAll({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.table,
        this.totalcount,
        this.totalAvailiable,
        this.totalUsed,
        this.totalReserved,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<Table>? table;
    int? totalcount;
    int? totalAvailiable;
    int? totalUsed;
    int? totalReserved;

    factory GetTableAll.fromJson(Map<String, dynamic> json) => GetTableAll(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        table: List<Table>.from(json["table"].map((x) => Table.fromJson(x))),
        totalcount: json["totalcount"],
        totalAvailiable: json["totalAvailiable"],
        totalUsed: json["totalUsed"],
        totalReserved: json["totalReserved"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "table": List<dynamic>.from(table!.map((x) => x.toJson())),
        "totalcount": totalcount,
        "totalAvailiable": totalAvailiable,
        "totalUsed": totalUsed,
        "totalReserved": totalReserved,
    };
}

class Table {
    Table({
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

    factory Table.fromJson(Map<String, dynamic> json) => Table(
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
