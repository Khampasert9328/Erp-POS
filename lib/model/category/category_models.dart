// To parse this JSON data, do
//
//     final getCategoryModels = getCategoryModelsFromJson(jsonString);

import 'dart:convert';

GetCategoryModels getCategoryModelsFromJson(String str) => GetCategoryModels.fromJson(json.decode(str));

String getCategoryModelsToJson(GetCategoryModels data) => json.encode(data.toJson());

class GetCategoryModels {
    GetCategoryModels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.category,
        this.totalcount,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<Category>? category;
    int? totalcount;

    factory GetCategoryModels.fromJson(Map<String, dynamic> json) => GetCategoryModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
        totalcount: json["totalcount"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "category": List<dynamic>.from(category!.map((x) => x.toJson())),
        "totalcount": totalcount,
    };
}

class Category {
    Category({
        this.id,
        this.uuid,
        this.cate,
        this.thumbnails,
        this.posid,
        this.status,
        this.postype,
        this.selected,
    });

    String? id;
    String? uuid;
    String? cate;
    List<Thumbnail>? thumbnails;
    String? posid;
    String? status;
    String? postype;
    bool? selected;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        uuid: json["uuid"],
        cate: json["cate"],
        thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        posid: json["posid"],
        status: json["status"],
        postype: json["postype"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "cate": cate,
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "posid": posid,
        "status": status,
        "postype": postype,
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
