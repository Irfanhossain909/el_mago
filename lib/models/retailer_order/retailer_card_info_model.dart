import 'dart:convert';

class RetailerCardInfoModel {
    bool? success;
    String? message;
    RetailerCardInfoModelData? data;

    RetailerCardInfoModel({
        this.success,
        this.message,
        this.data,
    });

    factory RetailerCardInfoModel.fromRawJson(String str) => RetailerCardInfoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerCardInfoModel.fromJson(Map<String, dynamic> json) => RetailerCardInfoModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : RetailerCardInfoModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class RetailerCardInfoModelData {
    int? totalSales;
    int? totalOrders;
    Card? card;
    RetailerInfo? retailerInfo;

    RetailerCardInfoModelData({
        this.totalSales,
        this.totalOrders,
        this.card,
        this.retailerInfo,
    });

    factory RetailerCardInfoModelData.fromRawJson(String str) => RetailerCardInfoModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerCardInfoModelData.fromJson(Map<String, dynamic> json) => RetailerCardInfoModelData(
        totalSales: json["totalSales"],
        totalOrders: json["totalOrders"],
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
        retailerInfo: json["retailerInfo"] == null ? null : RetailerInfo.fromJson(json["retailerInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "totalSales": totalSales,
        "totalOrders": totalOrders,
        "card": card?.toJson(),
        "retailerInfo": retailerInfo?.toJson(),
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

class RetailerInfo {
    String? phone;
    String? language;
    String? id;
    String? name;
    String? role;
    String? email;
    AssignedSalesRep? assignedSalesRep;
    String? image;
    String? status;
    String? address;
    bool? verified;
    bool? verifiedByAdmin;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    List<dynamic>? assignedRetailers;

    RetailerInfo({
        this.phone,
        this.language,
        this.id,
        this.name,
        this.role,
        this.email,
        this.assignedSalesRep,
        this.image,
        this.status,
        this.address,
        this.verified,
        this.verifiedByAdmin,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.assignedRetailers,
    });

    factory RetailerInfo.fromRawJson(String str) => RetailerInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerInfo.fromJson(Map<String, dynamic> json) => RetailerInfo(
        phone: json["phone"],
        language: json["language"],
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        assignedSalesRep: json["assignedSalesRep"] == null ? null : AssignedSalesRep.fromJson(json["assignedSalesRep"]),
        image: json["image"],
        status: json["status"],
        address: json["address"],
        verified: json["verified"],
        verifiedByAdmin: json["verifiedByAdmin"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        assignedRetailers: json["assignedRetailers"] == null ? [] : List<dynamic>.from(json["assignedRetailers"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "language": language,
        "_id": id,
        "name": name,
        "role": role,
        "email": email,
        "assignedSalesRep": assignedSalesRep?.toJson(),
        "image": image,
        "status": status,
        "address": address,
        "verified": verified,
        "verifiedByAdmin": verifiedByAdmin,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "assignedRetailers": assignedRetailers == null ? [] : List<dynamic>.from(assignedRetailers!.map((x) => x)),
    };
}

class AssignedSalesRep {
    String? id;
    String? name;
    String? email;

    AssignedSalesRep({
        this.id,
        this.name,
        this.email,
    });

    factory AssignedSalesRep.fromRawJson(String str) => AssignedSalesRep.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AssignedSalesRep.fromJson(Map<String, dynamic> json) => AssignedSalesRep(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
    };
}
