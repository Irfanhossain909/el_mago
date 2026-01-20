import 'dart:convert';

class NotificationModel {
    bool? success;
    String? message;
    Pagination? pagination;
    NotificationModelData? data;

    NotificationModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? null : NotificationModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data?.toJson(),
    };
}

class NotificationModelData {
    List<Result>? result;
    int? unreadCount;

    NotificationModelData({
        this.result,
        this.unreadCount,
    });

    factory NotificationModelData.fromRawJson(String str) => NotificationModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationModelData.fromJson(Map<String, dynamic> json) => NotificationModelData(
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        unreadCount: json["unreadCount"],
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
        "unreadCount": unreadCount,
    };
}

class Result {
    String? id;
    String? message;
    String? title;
    Receiver? receiver;
    bool? read;
    String? type;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    Result({
        this.id,
        this.message,
        this.title,
        this.receiver,
        this.read,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        message: json["message"],
        title: json["title"],
        receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
        read: json["read"],
        type: json["type"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "title": title,
        "receiver": receiver?.toJson(),
        "read": read,
        "type": type,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Receiver {
    String? id;
    String? name;
    String? email;

    Receiver({
        this.id,
        this.name,
        this.email,
    });

    factory Receiver.fromRawJson(String str) => Receiver.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
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
