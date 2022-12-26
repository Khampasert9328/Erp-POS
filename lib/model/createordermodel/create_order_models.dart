// To parse this JSON data, do
//
//     final createOrderModels = createOrderModelsFromJson(jsonString);

import 'dart:convert';

CreateOrderModels createOrderModelsFromJson(String str) => CreateOrderModels.fromJson(json.decode(str));

String createOrderModelsToJson(CreateOrderModels data) => json.encode(data.toJson());

class CreateOrderModels {
    CreateOrderModels({
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

    factory CreateOrderModels.fromJson(Map<String, dynamic> json) => CreateOrderModels(
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
