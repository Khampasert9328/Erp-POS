// To parse this JSON data, do
//
//     final getOrderByListId = getOrderByListIdFromJson(jsonString);

import 'dart:convert';

GetOrderByListId getOrderByListIdFromJson(String str) => GetOrderByListId.fromJson(json.decode(str));

String getOrderByListIdToJson(GetOrderByListId data) => json.encode(data.toJson());

class GetOrderByListId {
    GetOrderByListId({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.bill,
        this.totalcount,
        this.totalbillprice,
        this.totalbillIdlist,
        this.totalbillcanprint,
        this.prefixtoday,
        this.totalprice,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<Bill>? bill;
    int? totalcount;
    int? totalbillprice;
    int? totalbillIdlist;
    int? totalbillcanprint;
    int? prefixtoday;
    int? totalprice;

    factory GetOrderByListId.fromJson(Map<String, dynamic> json) => GetOrderByListId(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        bill: List<Bill>.from(json["bill"].map((x) => Bill.fromJson(x))),
        totalcount: json["totalcount"],
        totalbillprice: json["totalbillprice"],
        totalbillIdlist: json["totalbillIdlist"],
        totalbillcanprint: json["totalbillcanprint"],
        prefixtoday: json["prefixtoday"],
        totalprice: json["totalprice"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "bill": List<dynamic>.from(bill!.map((x) => x.toJson())),
        "totalcount": totalcount,
        "totalbillprice": totalbillprice,
        "totalbillIdlist": totalbillIdlist,
        "totalbillcanprint": totalbillcanprint,
        "prefixtoday": prefixtoday,
        "totalprice": totalprice,
    };
}

class Bill {
    Bill({
        this.id,
        this.prefixid,
        this.issuedate,
        this.date,
        this.discount,
        this.totalPrice,
        this.paid,
        this.credit,
        this.customerid,
        this.paymentmethod,
        this.timereport,
        this.time,
        this.selected,
    });

    String? id;
    String? prefixid;
    String? issuedate;
    String? date;
    int? discount;
    int? totalPrice;
    int? paid;
    int? credit;
    String? customerid;
    int? paymentmethod;
    String? timereport;
    String? time;
    bool? selected;

    factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        prefixid: json["prefixid"],
        issuedate: json["issuedate"],
        date: json["date"],
        discount: json["discount"],
        totalPrice: json["total_price"],
        paid: json["paid"],
        credit: json["credit"],
        customerid: json["customerid"],
        paymentmethod: json["paymentmethod"],
        timereport: json["timereport"],
        time: json["time"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "prefixid": prefixid,
        "issuedate": issuedate,
        "date": date,
        "discount": discount,
        "total_price": totalPrice,
        "paid": paid,
        "credit": credit,
        "customerid": customerid,
        "paymentmethod": paymentmethod,
        "timereport": timereport,
        "time": time,
        "selected": selected,
    };
}
