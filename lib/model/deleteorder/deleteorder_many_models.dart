// To parse this JSON data, do
//
//     final deleteOrderManyModels = deleteOrderManyModelsFromJson(jsonString);

import 'dart:convert';

DeleteOrderManyModels deleteOrderManyModelsFromJson(String str) => DeleteOrderManyModels.fromJson(json.decode(str));

String deleteOrderManyModelsToJson(DeleteOrderManyModels data) => json.encode(data.toJson());

class DeleteOrderManyModels {
    DeleteOrderManyModels({
        required this.issucess,
        required this.error,
        required this.id,
        required this.code,
        required this.billNo,
        required this.totalbillcanprint,
        required this.billid,
        required this.jobid,
    });

    bool issucess;
    String error;
    String id;
    String code;
    String billNo;
    int totalbillcanprint;
    String billid;
    List<String> jobid;

    factory DeleteOrderManyModels.fromJson(Map<String, dynamic> json) => DeleteOrderManyModels(
        issucess: json["issucess"],
        error: json["error"],
        id: json["id"],
        code: json["code"],
        billNo: json["billNo"],
        totalbillcanprint: json["totalbillcanprint"],
        billid: json["billid"],
        jobid: List<String>.from(json["jobid"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "issucess": issucess,
        "error": error,
        "id": id,
        "code": code,
        "billNo": billNo,
        "totalbillcanprint": totalbillcanprint,
        "billid": billid,
        "jobid": List<dynamic>.from(jobid.map((x) => x)),
    };
}
