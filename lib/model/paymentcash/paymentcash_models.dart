// To parse this JSON data, do
//
//     final createPaymentCashModels = createPaymentCashModelsFromJson(jsonString);

import 'dart:convert';

CreatePaymentCashModels createPaymentCashModelsFromJson(String str) => CreatePaymentCashModels.fromJson(json.decode(str));

String createPaymentCashModelsToJson(CreatePaymentCashModels data) => json.encode(data.toJson());

class CreatePaymentCashModels {
    CreatePaymentCashModels({
        this.isSuccess,
        this.code,
        this.error,
        this.id,
        this.billNo,
        this.totalBillCanPrint,
        this.billId,
        this.jobId,
    });

    bool? isSuccess;
    String? code;
    String? error;
    String? id;
    String? billNo;
    int? totalBillCanPrint;
    String? billId;
    List<String>? jobId;

    factory CreatePaymentCashModels.fromJson(Map<String, dynamic> json) => CreatePaymentCashModels(
        isSuccess: json["isSuccess"],
        code: json["code"],
        error: json["error"],
        id: json["id"],
        billNo: json["billNo"],
        totalBillCanPrint: json["totalBillCanPrint"],
        billId: json["billId"],
        jobId: List<String>.from(json["jobId"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "code": code,
        "error": error,
        "id": id,
        "billNo": billNo,
        "totalBillCanPrint": totalBillCanPrint,
        "billId": billId,
        "jobId": List<dynamic>.from(jobId!.map((x) => x)),
    };
}
