// To parse this JSON data, do
//
//     final getSessoin = getSessoinFromJson(jsonString);

import 'dart:convert';

GetSessoin getSessoinFromJson(String str) => GetSessoin.fromJson(json.decode(str));

String getSessoinToJson(GetSessoin data) => json.encode(data.toJson());

class GetSessoin {
    GetSessoin({
        this.code,
        this.success,
        this.message,
        this.detail,
        this.sessionItems,
        this.totalcount,
    });

    String? code;
    bool? success;
    String? message;
    String? detail;
    List<SessionItem>? sessionItems;
    int? totalcount;

    factory GetSessoin.fromJson(Map<String, dynamic> json) => GetSessoin(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        detail: json["detail"],
        sessionItems: List<SessionItem>.from(json["sessionItems"].map((x) => SessionItem.fromJson(x))),
        totalcount: json["totalcount"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "detail": detail,
        "sessionItems": List<dynamic>.from(sessionItems!.map((x) => x.toJson())),
        "totalcount": totalcount,
    };
}

class SessionItem {
    SessionItem({
        this.id,
        this.userOpen,
        this.userClose,
        this.userOpenName,
        this.userCloseName,
        this.openDate,
        this.closeDate,
        this.status,
        this.cashOpen,
        this.cashCount,
        this.bills,
        this.remark,
        this.selected,
    });

    String? id;
    String? userOpen;
    String? userClose;
    String? userOpenName;
    String? userCloseName;
    String? openDate;
    String? closeDate;
    int? status;
    int? cashOpen;
    int? cashCount;
    List<Bill>? bills;
    String? remark;
    bool? selected;

    factory SessionItem.fromJson(Map<String, dynamic> json) => SessionItem(
        id: json["id"],
        userOpen: json["userOpen"],
        userClose: json["userClose"],
        userOpenName: json["userOpenName"],
        userCloseName: json["userCloseName"],
        openDate: json["openDate"],
        closeDate: json["closeDate"],
        status: json["status"],
        cashOpen: json["cashOpen"],
        cashCount: json["cashCount"],
        bills: List<Bill>.from(json["bills"].map((x) => Bill.fromJson(x))),
        remark: json["remark"],
        selected: json["selected"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userOpen": userOpen,
        "userClose": userClose,
        "userOpenName": userOpenName,
        "userCloseName": userCloseName,
        "openDate": openDate,
        "closeDate": closeDate,
        "status": status,
        "cashOpen": cashOpen,
        "cashCount": cashCount,
        "bills": List<dynamic>.from(bills!.map((x) => x.toJson())),
        "remark": remark,
        "selected": selected,
    };
}

class Bill {
    Bill({
        this.billId,
        this.total,
    });

    String? billId;
    int? total;

    factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        billId: json["billID"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "billID": billId,
        "total": total,
    };
}
