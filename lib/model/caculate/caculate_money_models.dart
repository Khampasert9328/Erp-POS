// To parse this JSON data, do
//
//     final caculateMoneyModels = caculateMoneyModelsFromJson(jsonString);

import 'dart:convert';

CaculateMoneyModels caculateMoneyModelsFromJson(String str) => CaculateMoneyModels.fromJson(json.decode(str));

String caculateMoneyModelsToJson(CaculateMoneyModels data) => json.encode(data.toJson());

class CaculateMoneyModels {
    CaculateMoneyModels({
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

    factory CaculateMoneyModels.fromJson(Map<String, dynamic> json) => CaculateMoneyModels(
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
