import 'dart:convert';

class SubModel {
    bool? success;
    String? message;
    List<SubModelData>? data;

    SubModel({
        this.success,
        this.message,
        this.data,
    });

    factory SubModel.fromRawJson(String str) => SubModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubModel.fromJson(Map<String, dynamic> json) => SubModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<SubModelData>.from(json["data"]!.map((x) => SubModelData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SubModelData {
    String? id;
    String? tier;
    String? subscription;
    String? boxPerMonth;
    String? freeShipping;
    String? noCreditCardFee;
    String? exclusiveProducts;
    String? limitedReleases;
    bool? termsAndConditionsAccepted;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    SubModelData({
        this.id,
        this.tier,
        this.subscription,
        this.boxPerMonth,
        this.freeShipping,
        this.noCreditCardFee,
        this.exclusiveProducts,
        this.limitedReleases,
        this.termsAndConditionsAccepted,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory SubModelData.fromRawJson(String str) => SubModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SubModelData.fromJson(Map<String, dynamic> json) => SubModelData(
        id: json["_id"],
        tier: json["tier"],
        subscription: json["subscription"],
        boxPerMonth: json["boxPerMonth"],
        freeShipping: json["freeShipping"],
        noCreditCardFee: json["noCreditCardFee"],
        exclusiveProducts: json["exclusiveProducts"],
        limitedReleases: json["limitedReleases"],
        termsAndConditionsAccepted: json["termsAndConditionsAccepted"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "tier": tier,
        "subscription": subscription,
        "boxPerMonth": boxPerMonth,
        "freeShipping": freeShipping,
        "noCreditCardFee": noCreditCardFee,
        "exclusiveProducts": exclusiveProducts,
        "limitedReleases": limitedReleases,
        "termsAndConditionsAccepted": termsAndConditionsAccepted,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
