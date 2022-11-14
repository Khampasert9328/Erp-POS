// To parse this JSON data, do
//
//     final getAccountModels = getAccountModelsFromJson(jsonString);

import 'dart:convert';

GetAccountModels getAccountModelsFromJson(String str) => GetAccountModels.fromJson(json.decode(str));

String getAccountModelsToJson(GetAccountModels data) => json.encode(data.toJson());

class GetAccountModels {
    GetAccountModels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.payment,
        this.totalcount,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<Payment>? payment;
    int? totalcount;

    factory GetAccountModels.fromJson(Map<String, dynamic> json) => GetAccountModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        payment: List<Payment>.from(json["payment"].map((x) => Payment.fromJson(x))),
        totalcount: json["totalcount"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "payment": List<dynamic>.from(payment!.map((x) => x.toJson())),
        "totalcount": totalcount,
    };
}

class Payment {
    Payment({
        this.id,
        this.accounttype,
        this.thumbnails,
        this.accountnumber,
        this.merchid,
        this.merchname,
        this.password,
        this.merchcode,
        this.shopcode,
        this.currecy,
        this.country,
        this.province,
        this.selected,
    });

    String? id;
    int? accounttype;
    List<Thumbnail>? thumbnails;
    String? accountnumber;
    String? merchid;
    String? merchname;
    String? password;
    String? merchcode;
    String? shopcode;
    int? currecy;
    String? country;
    String? province;
    bool? selected;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        accounttype: json["accounttype"],
        thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        accountnumber: json["accountnumber"],
        merchid: json["merchid"],
        merchname: json["merchname"],
        password: json["password"],
        merchcode: json["merchcode"],
        shopcode: json["shopcode"],
        currecy: json["currecy"],
        country: json["country"],
        province: json["province"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "accounttype": accounttype,
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "accountnumber": accountnumber,
        "merchid": merchid,
        "merchname": merchname,
        "password": password,
        "merchcode": merchcode,
        "shopcode": shopcode,
        "currecy": currecy,
        "country": country,
        "province": province,
        "selected": selected,
    };
}

class Thumbnail {
    Thumbnail({
        this.domain,
        this.bucket,
        this.filename,
        this.content,
        this.priority,
        this.uri,
    });

    String? domain;
    String? bucket;
    String? filename;
    String? content;
    String? priority;
    String? uri;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        domain: json["domain"],
        bucket: json["bucket"],
        filename: json["filename"],
        content: json["content"],
        priority: json["priority"],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "domain": domain,
        "bucket": bucket,
        "filename": filename,
        "content": content,
        "priority": priority,
        "uri": uri,
    };
}
