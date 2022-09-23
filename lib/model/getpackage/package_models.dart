// To parse this JSON data, do
//
//     final getPackageModels = getPackageModelsFromJson(jsonString);

import 'dart:convert';

GetPackageModels getPackageModelsFromJson(String str) => GetPackageModels.fromJson(json.decode(str));

String getPackageModelsToJson(GetPackageModels data) => json.encode(data.toJson());

class GetPackageModels {
    GetPackageModels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.packageCode,
        this.packageId,
        this.packageName,
        this.price,
        this.moduleType,
        this.period,
        this.descriptionEn,
        this.descriptionLa,
        this.optional,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    String? packageCode;
    String?packageId;
    String? packageName;
    int? price;
    int? moduleType;
    int? period;
    String? descriptionEn;
    String? descriptionLa;
    List<Optional>? optional;

    factory GetPackageModels.fromJson(Map<String, dynamic> json) => GetPackageModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        packageCode: json["packageCode"],
        packageId: json["packageID"],
        packageName: json["packageName"],
        price: json["price"],
        moduleType: json["moduleType"],
        period: json["period"],
        descriptionEn: json["descriptionEN"],
        descriptionLa: json["descriptionLA"],
        optional: List<Optional>.from(json["optional"].map((x) => Optional.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "packageCode": packageCode,
        "packageID": packageId,
        "packageName": packageName,
        "price": price,
        "moduleType": moduleType,
        "period": period,
        "descriptionEN": descriptionEn,
        "descriptionLA": descriptionLa,
        "optional": List<dynamic>.from(optional!.map((x) => x.toJson())),
    };
}

class Optional {
    Optional({
        this.nameLao,
        this.nameEnglish,
        this.value,
    });

    String? nameLao;
    String? nameEnglish;
    int? value;

    factory Optional.fromJson(Map<String, dynamic> json) => Optional(
        nameLao: json["nameLao"],
        nameEnglish: json["nameEnglish"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "nameLao": nameLao,
        "nameEnglish": nameEnglish,
        "value": value,
    };
}
