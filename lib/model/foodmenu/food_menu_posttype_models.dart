// To parse this JSON data, do
//
//     final getFoodMenuPostTypeModels = getFoodMenuPostTypeModelsFromJson(jsonString);

import 'dart:convert';

GetFoodMenuPostTypeModels getFoodMenuPostTypeModelsFromJson(String str) => GetFoodMenuPostTypeModels.fromJson(json.decode(str));

String getFoodMenuPostTypeModelsToJson(GetFoodMenuPostTypeModels data) => json.encode(data.toJson());

class GetFoodMenuPostTypeModels {
    GetFoodMenuPostTypeModels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.product,
        this.totalcount,
        this.totalcountBycategory,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<ProductType>? product;
    int? totalcount;
    int? totalcountBycategory;

    factory GetFoodMenuPostTypeModels.fromJson(Map<String, dynamic> json) => GetFoodMenuPostTypeModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        product: List<ProductType>.from(json["product"].map((x) => ProductType.fromJson(x))),
        totalcount: json["totalcount"],
        totalcountBycategory: json["totalcountBycategory"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "product": List<dynamic>.from(product!.map((x) => x.toJson())),
        "totalcount": totalcount,
        "totalcountBycategory": totalcountBycategory,
    };
}

class ProductType {
    ProductType({
        this.thumbnails,
        this.categoryid,
        this.name,
        this.size,
        this.pricesale,
        this.priceimport,
        this.status,
        this.uuid,
        this.id,
        this.postype,
        this.selected,
    });

    List<Thumbnail>? thumbnails;
    String? categoryid;
    String? name;
    List<Size>? size;
    int? pricesale;
    int? priceimport;
    String? status;
    String? uuid;
    String? id;
    String? postype;
    bool? selected;

    factory ProductType.fromJson(Map<String, dynamic> json) => ProductType(
        thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        categoryid: json["categoryid"],
        name: json["name"],
        size: List<Size>.from(json["size"].map((x) => Size.fromJson(x))),
        pricesale: json["pricesale"],
        priceimport: json["priceimport"],
        status: json["status"],
        uuid: json["uuid"],
        id: json["id"],
        postype: json["postype"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "categoryid": categoryid,
        "name": name,
        "size": List<dynamic>.from(size!.map((x) => x.toJson())),
        "pricesale": pricesale,
        "priceimport": priceimport,
        "status": status,
        "uuid": uuid,
        "id": id,
        "postype": postype,
        "selected": selected,
    };
}

class Size {
    Size({
        this.size,
        this.specialPrice,
    });

    int? size;
    int? specialPrice;

    factory Size.fromJson(Map<String, dynamic> json) => Size(
        size: json["size"],
        specialPrice: json["specialPrice"],
    );

    Map<String, dynamic> toJson() => {
        "size": size,
        "specialPrice": specialPrice,
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
