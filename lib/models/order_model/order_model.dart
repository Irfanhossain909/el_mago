

// Helper function to decode a list of orders from a JSON string
import 'dart:convert';

import 'package:intl/intl.dart';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

class OrderModel {
  final String id;
  final UserId userId;
  final String orderTerms;
  final List<Product> products;
  final String source;
  final int orderBoxs;
  final double totalAmount;
  final int commission;
  final String orderStatus;
  final String shippingAddress;
  final DateTime createdAt;
  final String orderId;

  OrderModel({
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

  // A getter to format the date nicely
  String get formattedCreatedAt => DateFormat('dd/MM/yyyy').format(createdAt);

  // A getter to calculate the total quantity of all products in the order
  int get totalQuantity => products.fold(0, (sum, item) => sum + item.quantity);

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
    orderTerms: json["orderTerms"],
    products: List<Product>.from(
      json["products"].map((x) => Product.fromJson(x)),
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

class UserId {
  final String id;
  final String name;

  UserId({
    required this.id,
    required this.name,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
      );
}

class Product {
  final String productId;
  final String name;
  final int quantity;
  final double totalAmount;
  final double price;
  final int backOrder;
  final String id;

  Product({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.totalAmount,
    required this.price,
    required this.backOrder,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    name: json["name"],
    quantity: json["quantity"],
    totalAmount: (json["totalAmount"] as num).toDouble(),
    price: (json["price"] as num).toDouble(),
    backOrder: json["backOrder"],
    id: json["_id"],
  );
}
