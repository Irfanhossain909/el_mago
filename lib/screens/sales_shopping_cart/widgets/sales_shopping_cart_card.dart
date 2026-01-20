import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/sales_shopping_cart/model/cart_item_model.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartItemCard extends StatelessWidget {
  final CartItemModel cartItem;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ShoppingCartItemCard({
    super.key,
    required this.cartItem,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.width(value: 8),
        vertical: AppSize.height(value: 8),
      ),
      padding: EdgeInsets.all(AppSize.width(value: 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.grey.withValues(alpha: .05),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          buildDetailRow("Product Name", cartItem.product.name),
          SizedBox(height: AppSize.height(value: 8)),
          buildDetailRow("Product Size", cartItem.product.size),
          SizedBox(height: AppSize.height(value: 8)),
          buildDetailRow("Box Count", cartItem.product.perBoxQty.toString()),
          SizedBox(height: AppSize.height(value: 8)),
          buildDetailRow("Product Price", "\$${cartItem.product.price}"),
          SizedBox(height: AppSize.height(value: 8)),
          buildQuantityRow("Box Count", cartItem),
          SizedBox(height: AppSize.height(value: 8)),
          // Obx is used here to rebuild only the total amount text when quantity changes
          Obx(
            () => buildDetailRow(
              "Total Amount",
              "\$${cartItem.totalPrice.toStringAsFixed(2)}",
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: title,
          color: AppColor.black,
          fontWeight: FontWeight.w800,
        ),
        AppText(
          data: value,
          color: AppColor.black,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget buildQuantityRow(String title, CartItemModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: title,
          color: AppColor.black,
          fontWeight: FontWeight.w800,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onDecrement,
                iconSize: 20,
              ),
              // Obx rebuilds the quantity text when it changes
              Obx(
                () => AppText(
                  data: item.quantity.value.toString(),
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onIncrement,
                iconSize: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
