import 'dart:convert';
import 'package:intl/intl.dart';

// Helper function to decode order history response from JSON string
OrderHistoryResponse orderHistoryResponseFromJson(String str) =>
    OrderHistoryResponse.fromJson(json.decode(str));

String orderHistoryResponseToJson(OrderHistoryResponse data) =>
    json.encode(data.toJson());

class OrderHistoryResponse {
  final bool success;
  final String message;
  final OrderHistoryData data;

  OrderHistoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResponse(
        success: json["success"],
        message: json["message"],
        data: OrderHistoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class OrderHistoryData {
  final List<OrderHistoryItem> orders;
  final OrderHistoryMeta meta;

  OrderHistoryData({required this.orders, required this.meta});

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) =>
      OrderHistoryData(
        orders: List<OrderHistoryItem>.from(
          json["orders"].map((x) => OrderHistoryItem.fromJson(x)),
        ),
        meta: OrderHistoryMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class OrderHistoryItem {
  final String id;
  final OrderHistoryUserId userId;
  final String orderTerms;
  final List<OrderHistoryProduct> products;
  final String source;
  final int orderBoxs;
  final double totalAmount;
  final int commission;
  final String orderStatus;
  final String shippingAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String orderId;

  OrderHistoryItem({
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
  });

  // A getter to format the date nicely
  String get formattedCreatedAt => DateFormat('dd/MM/yyyy').format(createdAt);

  // A getter to format the date with time
  String get formattedDetailedDate =>
      DateFormat('dd/MM/yyyy hh:mm a').format(createdAt);

  // A getter to calculate the total quantity of all products in the order
  int get totalQuantity => products.fold(0, (sum, item) => sum + item.quantity);

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) =>
      OrderHistoryItem(
        id: json["_id"],
        userId: OrderHistoryUserId.fromJson(json["userId"]),
        orderTerms: json["orderTerms"],
        products: List<OrderHistoryProduct>.from(
          json["products"].map((x) => OrderHistoryProduct.fromJson(x)),
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
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
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
  };
}

class OrderHistoryUserId {
  final String id;
  final String name;
  final String email;
  final OrderHistoryAssignedSalesRep assignedSalesRep;

  OrderHistoryUserId({
    required this.id,
    required this.name,
    required this.email,
    required this.assignedSalesRep,
  });

  factory OrderHistoryUserId.fromJson(Map<String, dynamic> json) =>
      OrderHistoryUserId(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        assignedSalesRep: OrderHistoryAssignedSalesRep.fromJson(
          json["assignedSalesRep"],
        ),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "assignedSalesRep": assignedSalesRep.toJson(),
  };
}

class OrderHistoryAssignedSalesRep {
  final String id;
  final String name;
  final String email;

  OrderHistoryAssignedSalesRep({
    required this.id,
    required this.name,
    required this.email,
  });

  factory OrderHistoryAssignedSalesRep.fromJson(Map<String, dynamic> json) =>
      OrderHistoryAssignedSalesRep(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "email": email};
}

class OrderHistoryProduct {
  final String productId;
  final String name;
  final int quantity;
  final double totalAmount;
  final double price;
  final int backOrder;
  final String id;

  OrderHistoryProduct({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.totalAmount,
    required this.price,
    required this.backOrder,
    required this.id,
  });

  factory OrderHistoryProduct.fromJson(Map<String, dynamic> json) =>
      OrderHistoryProduct(
        productId: json["productId"],
        name: json["name"],
        quantity: json["quantity"],
        totalAmount: (json["totalAmount"] as num).toDouble(),
        price: (json["price"] as num).toDouble(),
        backOrder: json["backOrder"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "quantity": quantity,
    "totalAmount": totalAmount,
    "price": price,
    "backOrder": backOrder,
    "_id": id,
  };
}

class OrderHistoryMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  OrderHistoryMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory OrderHistoryMeta.fromJson(Map<String, dynamic> json) =>
      OrderHistoryMeta(
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
