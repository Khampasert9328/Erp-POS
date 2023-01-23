// To parse this JSON data, do
//
//     final getOrderTableModels = getOrderTableModelsFromJson(jsonString);

import 'dart:convert';

GetOrderTableModels? getOrderTableModelsFromJson(String str) => GetOrderTableModels.fromJson(json.decode(str));

String getOrderTableModelsToJson(GetOrderTableModels? data) => json.encode(data!.toJson());

class GetOrderTableModels {
    GetOrderTableModels({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.order,
        this.totalcount,
        this.totalpriceproduct,
        this.prefix,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<Order?>? order;
    int? totalcount;
    int? totalpriceproduct;
    int? prefix;

    factory GetOrderTableModels.fromJson(Map<String, dynamic> json) => GetOrderTableModels(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        order: json["order"] == null ? [] : List<Order?>.from(json["order"]!.map((x) => Order.fromJson(x))),
        totalcount: json["totalcount"],
        totalpriceproduct: json["totalpriceproduct"],
        prefix: json["prefix"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "order": order == null ? [] : List<dynamic>.from(order!.map((x) => x!.toJson())),
        "totalcount": totalcount,
        "totalpriceproduct": totalpriceproduct,
        "prefix": prefix,
    };
}

class Order {
    Order({
        this.id,
        this.issuedate,
        this.date,
        this.billid,
        this.tableid,
        this.product,
        this.userid,
        this.description,
        this.status,
        this.selected,
    });

    String? id;
    String? issuedate;
    String? date;
    String? billid;
    String? tableid;
    List<Product?>? product;
    String? userid;
    Description? description;
    int? status;
    bool? selected;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        issuedate: json["issuedate"],
        date: json["date"],
        billid: json["billid"],
        tableid: json["tableid"],
        product: json["product"] == null ? [] : List<Product?>.from(json["product"]!.map((x) => Product.fromJson(x))),
        userid: json["userid"],
        description: Description.fromJson(json["description"]),
        status: json["status"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "issuedate": issuedate,
        "date": date,
        "billid": billid,
        "tableid": tableid,
        "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x!.toJson())),
        "userid": userid,
        "description": description!.toJson(),
        "status": status,
        "selected": selected,
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

class Product {
    Product({
        this.productid,
        this.name,
        this.size,
        this.amount,
        this.pricesale,
        this.priceimport,
        this.discount,
        this.freeamount,
        this.description,
        this.cooked,
        this.timecooked,
        this.category,
    });

    String? productid;
    String? name;
    int? size;
    int? amount;
    int? pricesale;
    int? priceimport;
    int? discount;
    int? freeamount;
    String? description;
    bool? cooked;
    String? timecooked;
    Category? category;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productid: json["productid"],
        name: json["name"],
        size: json["size"],
        amount: json["amount"],
        pricesale: json["pricesale"],
        priceimport: json["priceimport"],
        discount: json["discount"],
        freeamount: json["freeamount"],
        description: json["description"],
        cooked: json["cooked"],
        timecooked: json["timecooked"],
        category: Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "productid": productid,
        "name": name,
        "size": size,
        "amount": amount,
        "pricesale": pricesale,
        "priceimport": priceimport,
        "discount": discount,
        "freeamount": freeamount,
        "description": description,
        "cooked": cooked,
        "timecooked": timecooked,
        "category": category!.toJson(),
    };
}

class Category {
    Category({
        this.categoryid,
        this.categoryname,
    });

    String? categoryid;
    String? categoryname;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryid: json["categoryid"],
        categoryname: json["categoryname"],
    );

    Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "categoryname": categoryname,
    };
}
