// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.uuid,
    this.name,
    this.categoryid,
    this.image,
    this.size,
    this.pricesale,
    this.priceimport,
    this.status,
    this.postype,
    this.selected,
    this.sum,
  });

  String? id;
  String? uuid;
  String? name;
  String? categoryid;
  String? image;
  String? size;
  String? pricesale;
  String? priceimport;
  String? status;
  String? postype;
  String? selected;
  String? sum;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"].toString(),
        uuid: json["uuid"],
        name: json["name"],
        categoryid: json["categoryid"],
        image: json["image"],
        size: json["size"],
        pricesale: json["pricesale"].toString(),
        priceimport: json["priceimport"],
        status: json["status"],
        postype: json["postype"],
        selected: json["selected"],
        sum: json["sum"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "categoryid": categoryid,
        "image": image,
        "size": size,
        "pricesale": pricesale,
        "priceimport": priceimport,
        "status": status,
        "postype": postype,
        "selected": selected,
        "sum": sum,
      };
}
