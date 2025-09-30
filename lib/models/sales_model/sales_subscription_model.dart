import 'dart:convert';

class SalesSubscriptionModel {
  bool? success;
  String? message;
  SalesSubscriptionData? data;

  SalesSubscriptionModel({this.success, this.message, this.data});

  factory SalesSubscriptionModel.fromRawJson(String str) =>
      SalesSubscriptionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SalesSubscriptionModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : SalesSubscriptionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class SalesSubscriptionData {
  int? boxRequired;
  String? id;
  String? userId;
  String? tier;
  String? subscription;
  String? freeShipping;
  String? noCreditCardFee;
  String? exclusiveProducts;
  String? limitedReleases;
  bool? termsAndConditionsAccepted;
  CardData? card;
  String? status;
  DateTime? billingDate;
  List<ExtraBoxData>? extraBox;
  int? v;

  SalesSubscriptionData({
    this.boxRequired,
    this.id,
    this.userId,
    this.tier,
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

  // Computed properties for display
  String get displayTier => tier?.split(':').first.trim() ?? "Unknown";
  String get displayBoxRequired =>
      tier?.split(':').last.trim() ?? "Unknown boxes";

  factory SalesSubscriptionData.fromRawJson(String str) =>
      SalesSubscriptionData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SalesSubscriptionData.fromJson(Map<String, dynamic> json) =>
      SalesSubscriptionData(
        boxRequired: json["boxRequired"],
        id: json["_id"],
        userId: json["userId"],
        tier: json["tier"],
        subscription: json["subscription"],
        freeShipping: json["freeShipping"],
        noCreditCardFee: json["noCreditCardFee"],
        exclusiveProducts: json["exclusiveProducts"],
        limitedReleases: json["limitedReleases"],
        termsAndConditionsAccepted: json["termsAndConditionsAccepted"],
        card: json["card"] == null ? null : CardData.fromJson(json["card"]),
        status: json["status"],
        billingDate: json["billingDate"] == null
            ? null
            : DateTime.parse(json["billingDate"]),
        extraBox: json["extraBox"] == null
            ? []
            : List<ExtraBoxData>.from(
                json["extraBox"]!.map((x) => ExtraBoxData.fromJson(x)),
              ),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
    "boxRequired": boxRequired,
    "_id": id,
    "userId": userId,
    "tier": tier,
    "subscription": subscription,
    "freeShipping": freeShipping,
    "noCreditCardFee": noCreditCardFee,
    "exclusiveProducts": exclusiveProducts,
    "limitedReleases": limitedReleases,
    "termsAndConditionsAccepted": termsAndConditionsAccepted,
    "card": card?.toJson(),
    "status": status,
    "billingDate": billingDate?.toIso8601String(),
    "extraBox": extraBox == null
        ? []
        : List<dynamic>.from(extraBox!.map((x) => x.toJson())),
    "__v": v,
  };
}

class CardData {
  String? cardHolderName;
  String? cardNumber;
  String? expiryDate;
  String? cvv;
  String? zipCode;
  String? id;

  CardData({
    this.cardHolderName,
    this.cardNumber,
    this.expiryDate,
    this.cvv,
    this.zipCode,
    this.id,
  });

  factory CardData.fromRawJson(String str) =>
      CardData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CardData.fromJson(Map<String, dynamic> json) => CardData(
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

class ExtraBoxData {
  String? productId;
  String? name;
  String? size;
  int? price;
  int? quantity;
  String? id;

  ExtraBoxData({
    this.productId,
    this.name,
    this.size,
    this.price,
    this.quantity,
    this.id,
  });

  factory ExtraBoxData.fromRawJson(String str) =>
      ExtraBoxData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExtraBoxData.fromJson(Map<String, dynamic> json) => ExtraBoxData(
    productId: json["productId"],
    name: json["name"],
    size: json["size"],
    price: json["price"],
    quantity: json["quantity"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "size": size,
    "price": price,
    "quantity": quantity,
    "_id": id,
  };
}
