// To parse this JSON data, do
//
//     final offSesionModels = offSesionModelsFromJson(jsonString);

import 'dart:convert';

OffSesionModels offSesionModelsFromJson(String str) => OffSesionModels.fromJson(json.decode(str));

String offSesionModelsToJson(OffSesionModels data) => json.encode(data.toJson());

class OffSesionModels {
    OffSesionModels({
        this.isSuccess,
        this.code,
        this.error,
        this.id,
        this.billNo,
        this.totalBillCanPrint,
        this.billId,
    });

    bool? isSuccess;
    String? code;
    String? error;
    String? id;
    String? billNo;
    int? totalBillCanPrint;
    String? billId;

    factory OffSesionModels.fromJson(Map<String, dynamic> json) => OffSesionModels(
        isSuccess: json["isSuccess"],
        code: json["code"],
        error: json["error"],
        id: json["id"],
        billNo: json["billNo"],
        totalBillCanPrint: json["totalBillCanPrint"],
        billId: json["billId"],
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "code": code,
        "error": error,
        "id": id,
        "billNo": billNo,
        "totalBillCanPrint": totalBillCanPrint,
        "billId": billId,
    };
}
