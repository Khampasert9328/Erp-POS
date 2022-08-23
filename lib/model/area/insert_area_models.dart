// To parse this JSON data, do
//
//     final insertAreaModels = insertAreaModelsFromJson(jsonString);

import 'dart:convert';

InsertAreaModels insertAreaModelsFromJson(String str) => InsertAreaModels.fromJson(json.decode(str));

String insertAreaModelsToJson(InsertAreaModels data) => json.encode(data.toJson());

class InsertAreaModels {
    InsertAreaModels({
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

    factory InsertAreaModels.fromJson(Map<String, dynamic> json) => InsertAreaModels(
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
