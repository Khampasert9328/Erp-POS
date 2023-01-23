// To parse this JSON data, do
//
//     final updateOrderModels = updateOrderModelsFromJson(jsonString);

import 'dart:convert';

UpdateOrderModels? updateOrderModelsFromJson(String str) => UpdateOrderModels.fromJson(json.decode(str));

String updateOrderModelsToJson(UpdateOrderModels? data) => json.encode(data!.toJson());

class UpdateOrderModels {
    UpdateOrderModels({
        this.id,
        this.issueDate,
        this.date,
        this.billId,
        this.tableId,
        this.product,
        this.userId,
        this.description,
        this.status,
        this.domain,
        this.metaData,
        this.revision,
        this.isSelected,
        this.packageDateStart,
        this.packageDateEnd,
        this.select,
    });

    String? id;
    String? issueDate;
    String? date;
    String? billId;
    String? tableId;
    List<Product?>? product;
    String? userId;
    Description? description;
    int? status;
    String? domain;
    MetaData? metaData;
    String? revision;
    bool? isSelected;
    String? packageDateStart;
    String? packageDateEnd;
    bool? select;

    factory UpdateOrderModels.fromJson(Map<String, dynamic> json) => UpdateOrderModels(
        id: json["id"],
        issueDate: json["issueDate"],
        date: json["date"],
        billId: json["billId"],
        tableId: json["tableId"],
        product: json["product"] == null ? [] : List<Product?>.from(json["product"]!.map((x) => Product.fromJson(x))),
        userId: json["userId"],
        description: Description.fromJson(json["description"]),
        status: json["status"],
        domain: json["domain"],
        metaData: MetaData.fromJson(json["metaData"]),
        revision: json["revision"],
        isSelected: json["isSelected"],
        packageDateStart: json["packageDateStart"],
        packageDateEnd: json["packageDateEnd"],
        select: json["select"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "issueDate": issueDate,
        "date": date,
        "billId": billId,
        "tableId": tableId,
        "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x!.toJson())),
        "userId": userId,
        "description": description!.toJson(),
        "status": status,
        "domain": domain,
        "metaData": metaData!.toJson(),
        "revision": revision,
        "isSelected": isSelected,
        "packageDateStart": packageDateStart,
        "packageDateEnd": packageDateEnd,
        "select": select,
    };
}

class Description {
    Description({
        this.customerName,
        this.contact,
        this.village,
        this.district,
        this.province,
    });

    String? customerName;
    List<String?>? contact;
    String? village;
    String? district;
    String? province;

    factory Description.fromJson(Map<String, dynamic> json) => Description(
        customerName: json["customerName"],
        contact: json["contact"] == null ? [] : List<String?>.from(json["contact"]!.map((x) => x)),
        village: json["village"],
        district: json["district"],
        province: json["province"],
    );

    Map<String, dynamic> toJson() => {
        "customerName": customerName,
        "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x)),
        "village": village,
        "district": district,
        "province": province,
    };
}

class MetaData {
    MetaData({
        this.modified,
        this.modifiedId,
        this.ipAddress,
        this.createId,
        this.created,
        this.computer,
        this.note,
        this.jobId,
        this.domain,
    });

    int? modified;
    String? modifiedId;
    String? ipAddress;
    String? createId;
    int? created;
    String? computer;
    String? note;
    String? jobId;
    String? domain;

    factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        modified: json["modified"],
        modifiedId: json["modifiedID"],
        ipAddress: json["ipAddress"],
        createId: json["createID"],
        created: json["created"],
        computer: json["computer"],
        note: json["note"],
        jobId: json["jobId"],
        domain: json["domain"],
    );

    Map<String, dynamic> toJson() => {
        "modified": modified,
        "modifiedID": modifiedId,
        "ipAddress": ipAddress,
        "createID": createId,
        "created": created,
        "computer": computer,
        "note": note,
        "jobId": jobId,
        "domain": domain,
    };
}

class Product {
    Product({
        this.productId,
        this.name,
        this.size,
        this.amount,
        this.priceSale,
        this.priceImport,
        this.discount,
        this.freeamount,
        this.description,
        this.cooked,
        this.timeCooked,
        this.categoryOrder,
    });

    String? productId;
    String? name;
    int? size;
    int? amount;
    int? priceSale;
    int? priceImport;
    int? discount;
    int? freeamount;
    String? description;
    bool? cooked;
    String? timeCooked;
    CategoryOrder? categoryOrder;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        name: json["name"],
        size: json["size"],
        amount: json["amount"],
        priceSale: json["priceSale"],
        priceImport: json["priceImport"],
        discount: json["discount"],
        freeamount: json["freeamount"],
        description: json["description"],
        cooked: json["cooked"],
        timeCooked: json["timeCooked"],
        categoryOrder: CategoryOrder.fromJson(json["categoryOrder"]),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "size": size,
        "amount": amount,
        "priceSale": priceSale,
        "priceImport": priceImport,
        "discount": discount,
        "freeamount": freeamount,
        "description": description,
        "cooked": cooked,
        "timeCooked": timeCooked,
        "categoryOrder": categoryOrder!.toJson(),
    };
}

class CategoryOrder {
    CategoryOrder({
        this.categoryId,
        this.categoryName,
    });

    String? categoryId;
    String? categoryName;

    factory CategoryOrder.fromJson(Map<String, dynamic> json) => CategoryOrder(
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryName": categoryName,
    };
}
