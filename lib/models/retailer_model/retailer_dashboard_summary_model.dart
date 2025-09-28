class RetailerDashboardSummaryModel {
  final int totalPurchaseAmount;
  final int totalOrderCompleate;

  RetailerDashboardSummaryModel({
    required this.totalPurchaseAmount,
    required this.totalOrderCompleate,
  });

  factory RetailerDashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    return RetailerDashboardSummaryModel(
      totalPurchaseAmount: json['totalPurchaseAmount'] ?? 0,
      totalOrderCompleate: json['totalOrderCompleate'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalPurchaseAmount': totalPurchaseAmount,
      'totalOrderCompleate': totalOrderCompleate,
    };
  }
}
