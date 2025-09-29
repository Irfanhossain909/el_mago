class CurrentSubscriptionResponse {
  final bool success;
  final String message;
  final CurrentSubscriptionData data;

  CurrentSubscriptionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CurrentSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return CurrentSubscriptionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: CurrentSubscriptionData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class CurrentSubscriptionData {
  final String id;
  final String userId;
  final String tier;
  final int boxRequired;
  final String subscription;
  final String freeShipping;
  final String noCreditCardFee;
  final String exclusiveProducts;
  final String limitedReleases;
  final bool termsAndConditionsAccepted;
  final CardModel? card;
  final String status;
  final DateTime? billingDate;
  final List<dynamic> extraBox;

  CurrentSubscriptionData({
    required this.id,
    required this.userId,
    required this.tier,
    required this.boxRequired,
    required this.subscription,
    required this.freeShipping,
    required this.noCreditCardFee,
    required this.exclusiveProducts,
    required this.limitedReleases,
    required this.termsAndConditionsAccepted,
    this.card,
    required this.status,
    this.billingDate,
    required this.extraBox,
  });

  factory CurrentSubscriptionData.fromJson(Map<String, dynamic> json) {
    return CurrentSubscriptionData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      tier: json['tier'] ?? '',
      boxRequired: json['boxRequired'] ?? 0,
      subscription: json['subscription'] ?? '',
      freeShipping: json['freeShipping'] ?? '',
      noCreditCardFee: json['noCreditCardFee'] ?? '',
      exclusiveProducts: json['exclusiveProducts'] ?? '',
      limitedReleases: json['limitedReleases'] ?? '',
      termsAndConditionsAccepted: json['termsAndConditionsAccepted'] ?? false,
      card: json['card'] != null ? CardModel.fromJson(json['card']) : null,
      status: json['status'] ?? '',
      billingDate: json['billingDate'] != null
          ? DateTime.parse(json['billingDate'])
          : null,
      extraBox: json['extraBox'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'tier': tier,
      'boxRequired': boxRequired,
      'subscription': subscription,
      'freeShipping': freeShipping,
      'noCreditCardFee': noCreditCardFee,
      'exclusiveProducts': exclusiveProducts,
      'limitedReleases': limitedReleases,
      'termsAndConditionsAccepted': termsAndConditionsAccepted,
      'card': card?.toJson(),
      'status': status,
      'billingDate': billingDate?.toIso8601String(),
      'extraBox': extraBox,
    };
  }

  // Helper getters for display
  String get displayTier => subscription;
  String get displayBoxRequired => '$boxRequired boxes per month';
  String get displayMinimumBoxes => boxRequired.toString();
}

class CardModel {
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String zipCode;
  final String id;

  CardModel({
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.zipCode,
    required this.id,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardHolderName: json['cardHolderName'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      cvv: json['cvv'] ?? '',
      zipCode: json['zipCode'] ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'zipCode': zipCode,
      '_id': id,
    };
  }
}
