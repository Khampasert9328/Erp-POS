// To parse this JSON data, do
//
//     final deleteOrderAllModels = deleteOrderAllModelsFromJson(jsonString);

import 'dart:convert';

DeleteOrderAllModels deleteOrderAllModelsFromJson(String str) => DeleteOrderAllModels.fromJson(json.decode(str));

String deleteOrderAllModelsToJson(DeleteOrderAllModels data) => json.encode(data.toJson());

class DeleteOrderAllModels {
    DeleteOrderAllModels({
        required this.isSuccess,
        required this.code,
        required this.error,
        required this.id,
        required this.billNo,
        required this.totalBillCanPrint,
        required this.billId,
        required this.jobId,
    });

    bool isSuccess;
    String code;
    String error;
    String id;
    String billNo;
    int totalBillCanPrint;
    String billId;
    List<String> jobId;

    factory DeleteOrderAllModels.fromJson(Map<String, dynamic> json) => DeleteOrderAllModels(
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
        "jobId": List<dynamic>.from(jobId.map((x) => x)),
    };
}
