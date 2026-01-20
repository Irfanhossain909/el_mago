import 'dart:convert';

class AllRetailerModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<AlLRetailerModelData>? data;

    AllRetailerModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory AllRetailerModel.fromRawJson(String str) => AllRetailerModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AllRetailerModel.fromJson(Map<String, dynamic> json) => AllRetailerModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<AlLRetailerModelData>.from(json["data"]!.map((x) => AlLRetailerModelData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AlLRetailerModelData {
    String? id;
    String? name;
    String? role;
    String? email;
    dynamic assignedSalesRep;
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

    AlLRetailerModelData({
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

    factory AlLRetailerModelData.fromRawJson(String str) => AlLRetailerModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AlLRetailerModelData.fromJson(Map<String, dynamic> json) => AlLRetailerModelData(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        assignedSalesRep: json["assignedSalesRep"],
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
        "_id": id,
        "name": name,
        "role": role,
        "email": email,
        "assignedSalesRep": assignedSalesRep,
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
