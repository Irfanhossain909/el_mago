import 'dart:convert';

class LoyeltyModel {
    bool? success;
    String? message;
    LoyeltyModelData? data;

    LoyeltyModel({
        this.success,
        this.message,
        this.data,
    });

    factory LoyeltyModel.fromRawJson(String str) => LoyeltyModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoyeltyModel.fromJson(Map<String, dynamic> json) => LoyeltyModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : LoyeltyModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class LoyeltyModelData {
    Loyalty? loyalty;
    List<AvailableReward>? availableRewards;

    LoyeltyModelData({
        this.loyalty,
        this.availableRewards,
    });

    factory LoyeltyModelData.fromRawJson(String str) => LoyeltyModelData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoyeltyModelData.fromJson(Map<String, dynamic> json) => LoyeltyModelData(
        loyalty: json["loyalty"] == null ? null : Loyalty.fromJson(json["loyalty"]),
        availableRewards: json["availableRewards"] == null ? [] : List<AvailableReward>.from(json["availableRewards"]!.map((x) => AvailableReward.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "loyalty": loyalty?.toJson(),
        "availableRewards": availableRewards == null ? [] : List<dynamic>.from(availableRewards!.map((x) => x.toJson())),
    };
}

class AvailableReward {
    String? id;
    String? title;
    String? type;
    int? value;
    String? description;
    int? target;
    bool? isActive;
    bool? isDeleted;
    int? v;
    bool? isRedeemed;

    AvailableReward({
        this.id,
        this.title,
        this.type,
        this.value,
        this.description,
        this.target,
        this.isActive,
        this.isDeleted,
        this.v,
        this.isRedeemed,
    });

    factory AvailableReward.fromRawJson(String str) => AvailableReward.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AvailableReward.fromJson(Map<String, dynamic> json) => AvailableReward(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        value: json["value"],
        description: json["description"],
        target: json["target"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        v: json["__v"],
        isRedeemed: json["isRedeemed"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "value": value,
        "description": description,
        "target": target,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "__v": v,
        "isRedeemed": isRedeemed,
    };
}

class Loyalty {
    String? id;
    String? userId;
    int? totalSpent;
    List<AvailableReward>? rewardsRedeemed;
    String? memberId;
    DateTime? memberSince;
    int? v;
    int? totalRewardsRedeemed;
    int? uniqueRewardsRedeemed;

    Loyalty({
        this.id,
        this.userId,
        this.totalSpent,
        this.rewardsRedeemed,
        this.memberId,
        this.memberSince,
        this.v,
        this.totalRewardsRedeemed,
        this.uniqueRewardsRedeemed,
    });

    factory Loyalty.fromRawJson(String str) => Loyalty.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Loyalty.fromJson(Map<String, dynamic> json) => Loyalty(
        id: json["_id"],
        userId: json["userId"],
        totalSpent: json["totalSpent"],
        rewardsRedeemed: json["rewardsRedeemed"] == null ? [] : List<AvailableReward>.from(json["rewardsRedeemed"]!.map((x) => AvailableReward.fromJson(x))),
        memberId: json["memberId"],
        memberSince: json["memberSince"] == null ? null : DateTime.parse(json["memberSince"]),
        v: json["__v"],
        totalRewardsRedeemed: json["totalRewardsRedeemed"],
        uniqueRewardsRedeemed: json["uniqueRewardsRedeemed"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "totalSpent": totalSpent,
        "rewardsRedeemed": rewardsRedeemed == null ? [] : List<dynamic>.from(rewardsRedeemed!.map((x) => x.toJson())),
        "memberId": memberId,
        "memberSince": memberSince?.toIso8601String(),
        "__v": v,
        "totalRewardsRedeemed": totalRewardsRedeemed,
        "uniqueRewardsRedeemed": uniqueRewardsRedeemed,
    };
}
