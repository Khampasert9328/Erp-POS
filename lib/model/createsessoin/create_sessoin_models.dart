// To parse this JSON data, do
//
//     final createSession = createSessionFromJson(jsonString);

import 'dart:convert';

CreateSession createSessionFromJson(String str) => CreateSession.fromJson(json.decode(str));

String createSessionToJson(CreateSession data) => json.encode(data.toJson());

class CreateSession {
    CreateSession({
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

    factory CreateSession.fromJson(Map<String, dynamic> json) => CreateSession(
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
