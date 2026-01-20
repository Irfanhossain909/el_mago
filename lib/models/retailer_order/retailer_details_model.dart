import 'dart:convert';

class RetailerDetailsModelData {
  bool? success;
  String? message;
  RetailerDetailsDataModel? data;

  RetailerDetailsModelData({this.success, this.message, this.data});

  factory RetailerDetailsModelData.fromRawJson(String str) =>
      RetailerDetailsModelData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RetailerDetailsModelData.fromJson(Map<String, dynamic> json) =>
      RetailerDetailsModelData(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : RetailerDetailsDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class RetailerDetailsDataModel {
  String? id;
  String? name;
  String? role;
  String? email;
  dynamic assignedSalesRep;
  String? image;
  String? status;
  String? address;
  String? phone;
  bool? verified;
  bool? verifiedByAdmin;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<dynamic>? assignedRetailers;

  RetailerDetailsDataModel({
    this.id,
    this.name,
    this.role,
    this.email,
    this.assignedSalesRep,
    this.image,
    this.status,
    this.address,
    this.phone,
    this.verified,
    this.verifiedByAdmin,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.assignedRetailers,
  });

  factory RetailerDetailsDataModel.fromRawJson(String str) =>
      RetailerDetailsDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RetailerDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      RetailerDetailsDataModel(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        assignedSalesRep: json["assignedSalesRep"],
        image: json["image"],
        status: json["status"],
        address: json["address"],
        phone: json["phone"],
        verified: json["verified"],
        verifiedByAdmin: json["verifiedByAdmin"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        assignedRetailers: json["assignedRetailers"] == null
            ? []
            : List<dynamic>.from(json["assignedRetailers"]!.map((x) => x)),
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
    "phone": phone,
    "verified": verified,
    "verifiedByAdmin": verifiedByAdmin,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "assignedRetailers": assignedRetailers == null
        ? []
        : List<dynamic>.from(assignedRetailers!.map((x) => x)),
  };
}
