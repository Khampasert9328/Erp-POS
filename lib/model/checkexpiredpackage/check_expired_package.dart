// To parse this JSON data, do
//
//     final checkExpiredPackageMedels = checkExpiredPackageMedelsFromJson(jsonString);

import 'dart:convert';

CheckExpiredPackageMedels checkExpiredPackageMedelsFromJson(String str) => CheckExpiredPackageMedels.fromJson(json.decode(str));

String checkExpiredPackageMedelsToJson(CheckExpiredPackageMedels data) => json.encode(data.toJson());

class CheckExpiredPackageMedels {
    CheckExpiredPackageMedels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.txPayment,
        this.packageId,
        this.dateSubscribe,
        this.dateExpired,
        this.txLaoKyc,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    String? txPayment;
    String? packageId;
    String? dateSubscribe;
    String? dateExpired;
    String? txLaoKyc;

    factory CheckExpiredPackageMedels.fromJson(Map<String, dynamic> json) => CheckExpiredPackageMedels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        txPayment: json["txPayment"],
        packageId: json["packageID"],
        dateSubscribe: json["dateSubscribe"],
        dateExpired: json["dateExpired"],
        txLaoKyc: json["txLaoKYC"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "txPayment": txPayment,
        "packageID": packageId,
        "dateSubscribe": dateSubscribe,
        "dateExpired": dateExpired,
        "txLaoKYC": txLaoKyc,
    };
}
