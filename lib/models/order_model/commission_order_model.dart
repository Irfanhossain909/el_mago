import 'dart:convert';
import 'package:intl/intl.dart';

// Helper function to decode a list of commission orders from a JSON string
List<CommissionOrderModel> commissionOrderModelFromJson(String str) =>
    List<CommissionOrderModel>.from(
      json.decode(str).map((x) => CommissionOrderModel.fromJson(x)),
    );

class CommissionOrderModel {
  final String id;
  final String userId;
  final String orderTerms;
  final List<CommissionProduct> products;
  final String source;
  final int orderBoxs;
  final double totalAmount;
  final int commission;
  final String orderStatus;
  final String shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderId;
  final double totalCommission;

  CommissionOrderModel({
    required this.id,
    required this.userId,
    required this.orderTerms,
    required this.products,
    required this.source,
    required this.orderBoxs,
    required this.totalAmount,
    required this.commission,
    required this.orderStatus,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    required this.totalCommission,
  });

  // A getter to format the date nicely
  String get formattedCreatedAt => DateFormat('dd/MM/yy').format(createdAt);

  // A getter to calculate the total quantity of all products in the order
  int get totalQuantity => products.fold(0, (sum, item) => sum + item.quantity);

  factory CommissionOrderModel.fromJson(Map<String, dynamic> json) =>
      CommissionOrderModel(
        id: json["_id"],
        userId: json["userId"],
        orderTerms: json["orderTerms"],
        products: List<CommissionProduct>.from(
          json["products"].map((x) => CommissionProduct.fromJson(x)),
        ),
        source: json["source"],
        orderBoxs: json["orderBoxs"],
        totalAmount: (json["totalAmount"] as num).toDouble(),
        commission: json["commission"],
        orderStatus: json["orderStatus"],
        shippingAddress: json["shippingAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        orderId: json["orderId"],
        totalCommission: (json["totalCommission"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "orderTerms": orderTerms,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "source": source,
    "orderBoxs": orderBoxs,
    "totalAmount": totalAmount,
    "commission": commission,
    "orderStatus": orderStatus,
    "shippingAddress": shippingAddress,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "orderId": orderId,
    "totalCommission": totalCommission,
  };
}

class CommissionProduct {
  final String productId;
  final String name;
  final int quantity;
  final double totalAmount;
  final double price;
  final int backOrder;
  final String id;
  final double commissionAmount;
  final double totalQuentityBaseCommission;

  CommissionProduct({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.totalAmount,
    required this.price,
    required this.backOrder,
    required this.id,
    required this.commissionAmount,
    required this.totalQuentityBaseCommission,
  });

  factory CommissionProduct.fromJson(Map<String, dynamic> json) =>
      CommissionProduct(
        productId: json["productId"],
        name: json["name"],
        quantity: json["quantity"],
        totalAmount: (json["totalAmount"] as num).toDouble(),
        price: (json["price"] as num).toDouble(),
        backOrder: json["backOrder"],
        id: json["_id"],
        commissionAmount: (json["commissionAmount"] as num).toDouble(),
        totalQuentityBaseCommission:
            (json["totalQuentityBaseCommission"] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "quantity": quantity,
    "totalAmount": totalAmount,
    "price": price,
    "backOrder": backOrder,
    "_id": id,
    "commissionAmount": commissionAmount,
    "totalQuentityBaseCommission": totalQuentityBaseCommission,
  };
}

// Model for the API response wrapper
class CommissionOrderResponse {
  final bool success;
  final String message;
  final PaginationInfo pagination;
  final List<CommissionOrderModel> data;

  CommissionOrderResponse({
    required this.success,
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory CommissionOrderResponse.fromJson(Map<String, dynamic> json) =>
      CommissionOrderResponse(
        success: json["success"],
        message: json["message"],
        pagination: PaginationInfo.fromJson(json["pagination"]),
        data: List<CommissionOrderModel>.from(
          json["data"].map((x) => CommissionOrderModel.fromJson(x)),
        ),
      );
}

class PaginationInfo {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  PaginationInfo({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => PaginationInfo(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );
}
