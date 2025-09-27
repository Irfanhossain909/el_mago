import 'dart:convert';

class RetailerProductModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<RetailerProductModelData>? data;

    RetailerProductModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory RetailerProductModel.fromRawJson(String str) => RetailerProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerProductModel.fromJson(Map<String, dynamic> json) => RetailerProductModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<RetailerProductModelData>.from(json["data"]!.map((x) => RetailerProductModelData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RetailerProductModelData {
    String? id;
    String? name;
    String? size;
    int? perBoxQty;
    int? totalInventoryValue;
    int? quantity;
    int? price;
    List<String>? images;
    bool? lowStockAlert;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;

    RetailerProductModelData({
        this.id,
        this.name,
        this.size,
        this.perBoxQty,
        this.totalInventoryValue,
        this.quantity,
        this.price,
        this.images,
        this.lowStockAlert,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
    });

    factory RetailerProductModelData.fromRawJson(String str) => RetailerProductModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RetailerProductModelData.fromJson(Map<String, dynamic> json) => RetailerProductModelData(
        id: json["_id"],
        name: json["name"],
        size: json["size"],
        perBoxQty: json["perBoxQty"],
        totalInventoryValue: json["totalInventoryValue"],
        quantity: json["quantity"],
        price: json["price"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        lowStockAlert: json["lowStockAlert"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "size": size,
        "perBoxQty": perBoxQty,
        "totalInventoryValue": totalInventoryValue,
        "quantity": quantity,
        "price": price,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "lowStockAlert": lowStockAlert,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
