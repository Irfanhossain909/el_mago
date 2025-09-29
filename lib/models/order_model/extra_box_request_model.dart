import 'dart:convert';

/// Model for individual extra box item in the request
class ExtraBoxItem {
  final String productId;
  final String name;
  final String size;
  final int price;

  ExtraBoxItem({
    required this.productId,
    required this.name,
    required this.size,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "size": size,
    "price": price,
  };

  factory ExtraBoxItem.fromJson(Map<String, dynamic> json) => ExtraBoxItem(
    productId: json["productId"] ?? '',
    name: json["name"] ?? '',
    size: json["size"] ?? '',
    price: json["price"] ?? 0,
  );
}

/// Model for the complete extra box request
class ExtraBoxRequest {
  final List<ExtraBoxItem> extraBoxes;

  ExtraBoxRequest({required this.extraBoxes});

  Map<String, dynamic> toJson() => {
    "extraBoxes": extraBoxes.map((item) => item.toJson()).toList(),
  };

  factory ExtraBoxRequest.fromJson(Map<String, dynamic> json) =>
      ExtraBoxRequest(
        extraBoxes: List<ExtraBoxItem>.from(
          json["extraBoxes"]?.map((x) => ExtraBoxItem.fromJson(x)) ?? [],
        ),
      );

  String toJsonString() => json.encode(toJson());
}
