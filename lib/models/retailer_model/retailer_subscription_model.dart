import 'dart:convert';

class RetailerSubscriptionModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<RetailerSubscriptionModelData>? data;

    RetailerSubscriptionModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory RetailerSubscriptionModel.fromRawJson(String str) => RetailerSubscriptionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerSubscriptionModel.fromJson(Map<String, dynamic> json) => RetailerSubscriptionModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<RetailerSubscriptionModelData>.from(json["data"]!.map((x) => RetailerSubscriptionModelData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RetailerSubscriptionModelData {
    String? id;
    String? name;
    String? role;
    String? email;
    String? assignedSalesRep;
    List<dynamic>? assignedRetailers;
    String? image;
    String? status;
    String? address;
    String? phone;
    String? language;
    bool? verified;
    bool? verifiedByAdmin;
    bool? isDeleted;
    int? commission;
    List<dynamic>? territory;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    ActiveSubscription? activeSubscription;

    RetailerSubscriptionModelData({
        this.id,
        this.name,
        this.role,
        this.email,
        this.assignedSalesRep,
        this.assignedRetailers,
        this.image,
        this.status,
        this.address,
        this.phone,
        this.language,
        this.verified,
        this.verifiedByAdmin,
        this.isDeleted,
        this.commission,
        this.territory,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.activeSubscription,
    });

    factory RetailerSubscriptionModelData.fromRawJson(String str) => RetailerSubscriptionModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerSubscriptionModelData.fromJson(Map<String, dynamic> json) => RetailerSubscriptionModelData(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        assignedSalesRep: json["assignedSalesRep"],
        assignedRetailers: json["assignedRetailers"] == null ? [] : List<dynamic>.from(json["assignedRetailers"]!.map((x) => x)),
        image: json["image"],
        status: json["status"],
        address: json["address"],
        phone: json["phone"],
        language: json["language"],
        verified: json["verified"],
        verifiedByAdmin: json["verifiedByAdmin"],
        isDeleted: json["isDeleted"],
        commission: json["commission"],
        territory: json["territory"] == null ? [] : List<dynamic>.from(json["territory"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        activeSubscription: json["activeSubscription"] == null ? null : ActiveSubscription.fromJson(json["activeSubscription"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "email": email,
        "assignedSalesRep": assignedSalesRep,
        "assignedRetailers": assignedRetailers == null ? [] : List<dynamic>.from(assignedRetailers!.map((x) => x)),
        "image": image,
        "status": status,
        "address": address,
        "phone": phone,
        "language": language,
        "verified": verified,
        "verifiedByAdmin": verifiedByAdmin,
        "isDeleted": isDeleted,
        "commission": commission,
        "territory": territory == null ? [] : List<dynamic>.from(territory!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "activeSubscription": activeSubscription?.toJson(),
    };
}

class ActiveSubscription {
    String? id;
    String? userId;
    String? tier;
    int? boxRequired;
    String? subscription;
    String? freeShipping;
    String? noCreditCardFee;
    String? exclusiveProducts;
    String? limitedReleases;
    bool? termsAndConditionsAccepted;
    Card? card;
    String? status;
    DateTime? billingDate;
    List<dynamic>? extraBox;
    int? v;

    ActiveSubscription({
        this.id,
        this.userId,
        this.tier,
        this.boxRequired,
        this.subscription,
        this.freeShipping,
        this.noCreditCardFee,
        this.exclusiveProducts,
        this.limitedReleases,
        this.termsAndConditionsAccepted,
        this.card,
        this.status,
        this.billingDate,
        this.extraBox,
        this.v,
    });

    factory ActiveSubscription.fromRawJson(String str) => ActiveSubscription.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ActiveSubscription.fromJson(Map<String, dynamic> json) => ActiveSubscription(
        id: json["_id"],
        userId: json["userId"],
        tier: json["tier"],
        boxRequired: json["boxRequired"],
        subscription: json["subscription"],
        freeShipping: json["freeShipping"],
        noCreditCardFee: json["noCreditCardFee"],
        exclusiveProducts: json["exclusiveProducts"],
        limitedReleases: json["limitedReleases"],
        termsAndConditionsAccepted: json["termsAndConditionsAccepted"],
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
        status: json["status"],
        billingDate: json["billingDate"] == null ? null : DateTime.parse(json["billingDate"]),
        extraBox: json["extraBox"] == null ? [] : List<dynamic>.from(json["extraBox"]!.map((x) => x)),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "tier": tier,
        "boxRequired": boxRequired,
        "subscription": subscription,
        "freeShipping": freeShipping,
        "noCreditCardFee": noCreditCardFee,
        "exclusiveProducts": exclusiveProducts,
        "limitedReleases": limitedReleases,
        "termsAndConditionsAccepted": termsAndConditionsAccepted,
        "card": card?.toJson(),
        "status": status,
        "billingDate": billingDate?.toIso8601String(),
        "extraBox": extraBox == null ? [] : List<dynamic>.from(extraBox!.map((x) => x)),
        "__v": v,
    };
}

class Card {
    String? cardHolderName;
    String? cardNumber;
    String? expiryDate;
    String? cvv;
    String? zipCode;
    String? id;

    Card({
        this.cardHolderName,
        this.cardNumber,
        this.expiryDate,
        this.cvv,
        this.zipCode,
        this.id,
    });

    factory Card.fromRawJson(String str) => Card.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        cardHolderName: json["cardHolderName"],
        cardNumber: json["cardNumber"],
        expiryDate: json["expiryDate"],
        cvv: json["cvv"],
        zipCode: json["zipCode"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "cardHolderName": cardHolderName,
        "cardNumber": cardNumber,
        "expiryDate": expiryDate,
        "cvv": cvv,
        "zipCode": zipCode,
        "_id": id,
    };
}

class Pagination {
    int? page;
    int? limit;
    int? total;
    int? totalPage;

    Pagination({
        this.page,
        this.limit,
        this.total,
        this.totalPage,
    });

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPage: json["totalPage"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "total": total,
        "totalPage": totalPage,
    };
}
