// To parse this JSON data, do
//
//     final generateQrMmoney = generateQrMmoneyFromJson(jsonString);

import 'dart:convert';

GenerateQrMmoney generateQrMmoneyFromJson(String str) => GenerateQrMmoney.fromJson(json.decode(str));

String generateQrMmoneyToJson(GenerateQrMmoney data) => json.encode(data.toJson());

class GenerateQrMmoney {
    GenerateQrMmoney({
        this.error,
        this.data,
        this.message,
        this.qrcodeStr,
    });

    bool? error;
    Data? data;
    String? message;
    String? qrcodeStr;

    factory GenerateQrMmoney.fromJson(Map<String, dynamic> json) => GenerateQrMmoney(
        error: json["error"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        qrcodeStr: json["qrcodeStr"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "data": data!.toJson(),
        "message": message,
        "qrcodeStr": qrcodeStr,
    };
}

class Data {
    Data({
        this.fieldCount,
        this.affectedRows,
        this.insertId,
        this.serverStatus,
        this.warningCount,
        this.message,
        this.protocol41,
        this.changedRows,
    });

    int? fieldCount;
    int? affectedRows;
    int? insertId;
    int? serverStatus;
    int? warningCount;
    String? message;
    bool? protocol41;
    int? changedRows;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        fieldCount: json["fieldCount"],
        affectedRows: json["affectedRows"],
        insertId: json["insertId"],
        serverStatus: json["serverStatus"],
        warningCount: json["warningCount"],
        message: json["message"],
        protocol41: json["protocol41"],
        changedRows: json["changedRows"],
    );

    Map<String, dynamic> toJson() => {
        "fieldCount": fieldCount,
        "affectedRows": affectedRows,
        "insertId": insertId,
        "serverStatus": serverStatus,
        "warningCount": warningCount,
        "message": message,
        "protocol41": protocol41,
        "changedRows": changedRows,
    };
}
