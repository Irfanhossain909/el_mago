class RewardModel {
  final String id;
  final String title;
  final String type; // "discount" or "fixedAmount"
  final int value;
  final String description;
  final int target;
  final bool isActive;
  final bool isDeleted;

  RewardModel({
    required this.id,
    required this.title,
    required this.type,
    required this.value,
    required this.description,
    required this.target,
    required this.isActive,
    required this.isDeleted,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      value: json['value'] ?? 0,
      description: json['description'] ?? '',
      target: json['target'] ?? 0,
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'type': type,
      'value': value,
      'description': description,
      'target': target,
      'isActive': isActive,
      'isDeleted': isDeleted,
    };
  }
}

class UserRewardModel {
  final String id;
  final String userId;
  final RewardModel rewardsRedeemed;

  UserRewardModel({
    required this.id,
    required this.userId,
    required this.rewardsRedeemed,
  });

  factory UserRewardModel.fromJson(Map<String, dynamic> json) {
    return UserRewardModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      rewardsRedeemed: RewardModel.fromJson(json['rewardsRedeemed'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'rewardsRedeemed': rewardsRedeemed.toJson(),
    };
  }

  // Helper methods for calculations
  bool get isDiscount => rewardsRedeemed.type == 'discount';
  bool get isFixedAmount => rewardsRedeemed.type == 'fixedAmount';

  double calculateDiscount(double originalAmount) {
    if (isDiscount) {
      return (originalAmount * rewardsRedeemed.value) / 100;
    } else if (isFixedAmount) {
      return rewardsRedeemed.value.toDouble();
    }
    return 0.0;
  }

  double calculateFinalAmount(double originalAmount) {
    double discount = calculateDiscount(originalAmount);
    return originalAmount - discount;
  }
}
