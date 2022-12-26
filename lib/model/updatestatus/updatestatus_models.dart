// To parse this JSON data, do
//
//     final updateStatusModels = updateStatusModelsFromJson(jsonString);

import 'dart:convert';

UpdateStatusModels updateStatusModelsFromJson(String str) => UpdateStatusModels.fromJson(json.decode(str));

String updateStatusModelsToJson(UpdateStatusModels data) => json.encode(data.toJson());

class UpdateStatusModels {
    UpdateStatusModels({
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

    factory UpdateStatusModels.fromJson(Map<String, dynamic> json) => UpdateStatusModels(
        isSuccess: json["isSuccess"],
        code: json["code"],
        error: json["error"],
        id: json["id"],
        billNo: json["billNo"],
        totalBillCanPrint: json["totalBillCanPrint"],
        billId: json["billId"],
        jobId: List<String>.from(json["jobid"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "code": code,
        "error": error,
        "id": id,
        "billNo": billNo,
        "totalBillCanPrint": totalBillCanPrint,
        "billId": billId,
        "jobid": List<dynamic>.from(jobId!.map((x) => x)),
    };
}
