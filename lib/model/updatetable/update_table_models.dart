// To parse this JSON data, do
//
//     final tableUpdateModels = tableUpdateModelsFromJson(jsonString);

import 'dart:convert';

TableUpdateModels tableUpdateModelsFromJson(String str) => TableUpdateModels.fromJson(json.decode(str));

String tableUpdateModelsToJson(TableUpdateModels data) => json.encode(data.toJson());

class TableUpdateModels {
    TableUpdateModels({
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

    factory TableUpdateModels.fromJson(Map<String, dynamic> json) => TableUpdateModels(
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
