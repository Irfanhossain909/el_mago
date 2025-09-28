import 'dart:convert';
import 'package:intl/intl.dart';

// Helper function to decode a list of orders from a JSON string
List<RetailerOrderModel> retailerOrderModelFromJson(String str) =>
    List<RetailerOrderModel>.from(
      json.decode(str).map((x) => RetailerOrderModel.fromJson(x)),
    );

class RetailerOrderModel {
  final String id;
  final String userId;
  final String orderTerms;
  final List<RetailerProduct> products;
  final String source;
  final int orderBoxs;
  final double totalAmount;
  final int commission;
  final String orderStatus;
  final String shippingAddress;
  final DateTime createdAt;
  final String orderId;

  RetailerOrderModel({
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
    required this.orderId,
  });

  // Getter to format the date for display
  String get formattedCreatedAt => DateFormat('dd/MM/yyyy').format(createdAt);
  String get formattedDetailedDate =>
      DateFormat('MMMM dd, yyyy').format(createdAt);

  // Getter to calculate the total quantity of items
  int get totalQuantity => products.fold(0, (sum, item) => sum + item.quantity);

  factory RetailerOrderModel.fromJson(Map<String, dynamic> json) =>
      RetailerOrderModel(
        id: json["_id"],
        userId: json["userId"] is String
            ? json["userId"]
            : json["userId"]["_id"], // Handles both list and detail views
        orderTerms: json["orderTerms"],
        products: List<RetailerProduct>.from(
          json["products"].map((x) => RetailerProduct.fromJson(x)),
        ),
        source: json["source"],
        orderBoxs: json["orderBoxs"],
        totalAmount: (json["totalAmount"] as num).toDouble(),
        commission: json["commission"],
        orderStatus: json["orderStatus"],
        shippingAddress: json["shippingAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
        orderId: json["orderId"],
      );
}

class RetailerProduct {
  final String productId;
  final String name;
  final int quantity;
  final double totalAmount;
  final double price;
  final int backOrder;
  final String id;

  RetailerProduct({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.totalAmount,
    required this.price,
    required this.backOrder,
    required this.id,
  });

  factory RetailerProduct.fromJson(Map<String, dynamic> json) {
    // This factory handles both cases: where productId is a string (list view)
    // or an object (detail view).
    var pId = json["productId"];
    String finalProductId = pId is String ? pId : pId["_id"];
    String finalProductName = pId is String ? json["name"] : pId["name"];

    return RetailerProduct(
      productId: finalProductId,
      name: finalProductName,
      quantity: json["quantity"],
      totalAmount: (json["totalAmount"] as num).toDouble(),
      price: (json["price"] as num).toDouble(),
      backOrder: json["backOrder"],
      id: json["_id"],
    );
  }
}
