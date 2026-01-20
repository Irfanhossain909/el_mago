import 'package:el_mago/models/product_model/product_model.dart';
import 'package:get/get.dart';

class CartItemModel {
  final ProductModel product;
  RxInt quantity; // Using RxInt to make it observable

  CartItemModel({required this.product, int initialQuantity = 1})
    : quantity = initialQuantity.obs;

  // Calculated property for total price of this item
  double get totalPrice => (product.price * quantity.value).toDouble();
}
