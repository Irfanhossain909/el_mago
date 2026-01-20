import 'dart:convert';

class UserModel {
    bool? success;
    String? message;
    UserModelData? data;

    UserModel({
        this.success,
        this.message,
        this.data,
    });

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class UserModelData {
    String? id;
    String? name;
    String? role;
    String? email;
    dynamic assignedSalesRep;
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

    UserModelData({
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
    });

    factory UserModelData.fromRawJson(String str) => UserModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModelData.fromJson(Map<String, dynamic> json) => UserModelData(
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
    };
}
