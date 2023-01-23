// To parse this JSON data, do
//
//     final createOrderAgainModles = createOrderAgainModlesFromJson(jsonString);

import 'dart:convert';

CreateOrderAgainModles? createOrderAgainModlesFromJson(String str) => CreateOrderAgainModles.fromJson(json.decode(str));

String createOrderAgainModlesToJson(CreateOrderAgainModles? data) => json.encode(data!.toJson());

class CreateOrderAgainModles {
    CreateOrderAgainModles({
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
    List<String?>? jobId;

    factory CreateOrderAgainModles.fromJson(Map<String, dynamic> json) => CreateOrderAgainModles(
        isSuccess: json["isSuccess"],
        code: json["code"],
        error: json["error"],
        id: json["id"],
        billNo: json["billNo"],
        totalBillCanPrint: json["totalBillCanPrint"],
        billId: json["billId"],
        jobId: json["jobId"] == null ? [] : List<String?>.from(json["jobId"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "code": code,
        "error": error,
        "id": id,
        "billNo": billNo,
        "totalBillCanPrint": totalBillCanPrint,
        "billId": billId,
        "jobId": jobId == null ? [] : List<dynamic>.from(jobId!.map((x) => x)),
    };
}
