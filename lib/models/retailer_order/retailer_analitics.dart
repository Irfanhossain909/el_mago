import 'dart:convert';

class RetailerAnalitics {
    bool? success;
    String? message;
    RetailerAnaliticsData? data;

    RetailerAnalitics({
        this.success,
        this.message,
        this.data,
    });

    factory RetailerAnalitics.fromRawJson(String str) => RetailerAnalitics.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerAnalitics.fromJson(Map<String, dynamic> json) => RetailerAnalitics(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : RetailerAnaliticsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class RetailerAnaliticsData {
    dynamic id;
    int? totalOrders;
    int? totalRevenue;

    RetailerAnaliticsData({
        this.id,
        this.totalOrders,
        this.totalRevenue,
    });

    factory RetailerAnaliticsData.fromRawJson(String str) => RetailerAnaliticsData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerAnaliticsData.fromJson(Map<String, dynamic> json) => RetailerAnaliticsData(
        id: json["_id"],
        totalOrders: json["totalOrders"],
        totalRevenue: json["totalRevenue"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "totalOrders": totalOrders,
        "totalRevenue": totalRevenue,
    };
}
