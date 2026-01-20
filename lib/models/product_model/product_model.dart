import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
  json.decode(str).map((x) => ProductModel.fromJson(x)),
);

class ProductModel {
  final String id;
  final String name;
  final String size;
  final int perBoxQty;
  final int totalInventoryValue;
  final int quantity;
  final int price;
  final List<String> images;
  final bool lowStockAlert;

  ProductModel({
    required this.id,
    required this.name,
    required this.size,
    required this.perBoxQty,
    required this.totalInventoryValue,
    required this.quantity,
    required this.price,
    required this.images,
    required this.lowStockAlert,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"] ?? '',
    name: json["name"] ?? 'Unknown Product',
    size: json["size"] ?? '',
    perBoxQty: json["perBoxQty"] ?? 0,
    totalInventoryValue: json["totalInventoryValue"] ?? 0,
    quantity: json["quantity"] ?? 0,
    price: json["price"] ?? 0,
    images: List<String>.from(json["images"]?.map((x) => x) ?? []),
    lowStockAlert: json["lowStockAlert"] ?? false,
  );
}
