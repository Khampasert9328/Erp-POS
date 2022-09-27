// To parse this JSON data, do
//
//     final getFoodMenuModels = getFoodMenuModelsFromJson(jsonString);

import 'dart:convert';

GetFoodMenuModels getFoodMenuModelsFromJson(String str) => GetFoodMenuModels.fromJson(json.decode(str));

String getFoodMenuModelsToJson(GetFoodMenuModels data) => json.encode(data.toJson());

class GetFoodMenuModels {
    GetFoodMenuModels({
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
    List<Product>? product;
    int? totalcount;
    int? totalcountBycategory;

    factory GetFoodMenuModels.fromJson(Map<String, dynamic> json) => GetFoodMenuModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
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

class Product {
    Product({
        this.thumbnails,
        this.categoryid,
        this.categoryname,
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
    String? categoryname;
    String? name;
    List<Size>? size;
    int? pricesale;
    int? priceimport;
    String? status;
    String? uuid;
    String? id;
    String? postype;
    bool? selected;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
