import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/retailer_shopping_cart/controller/retailer_shopping_cart_controller.dart';
import 'package:el_mago/screens/sales_shopping_cart/model/cart_item_model.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_dropdown/custom_sdropdown.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerShoppingCart extends StatelessWidget {
  const RetailerShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RetailerShoppingCartController());

    return Scaffold(
      appBar: CustomAppbar(title: 'Shopping Cart'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 16)),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => controller.cartItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: AppSize.width(value: 64),
                              color: AppColor.black.withValues(alpha: 0.3),
                            ),
                            Gap(height: AppSize.size.height * 0.02),
                            AppText(
                              data: "Your cart is empty",
                              fontSize: AppSize.width(value: 18),
                              fontWeight: FontWeight.w600,
                              color: AppColor.black.withValues(alpha: 0.6),
                            ),
                            Gap(height: AppSize.size.height * 0.01),
                            AppText(
                              data:
                                  "Add products to your cart to see them here",
                              fontSize: AppSize.width(value: 14),
                              fontWeight: FontWeight.w400,
                              color: AppColor.black.withValues(alpha: 0.4),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = controller.cartItems[index];
                          return ShoppingCard(
                            cartItem: cartItem,
                            controller: controller,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => controller.cartItems.isEmpty
            ? const SizedBox.shrink()
            : SafeArea(
                child: Container(
                  padding: EdgeInsets.all(AppSize.width(value: 16)),
                  // height: AppSize.size.height * 0.45,
                  color: AppColor.blue,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data: "Shopping Cart",
                        fontSize: AppSize.width(value: 18),
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                      Gap(height: AppSize.size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            data: "Total Box",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w600,
                            color: AppColor.white,
                          ),
                          Obx(
                            () => AppText(
                              data: "${controller.totalBoxCount}",
                              fontSize: AppSize.width(value: 16),
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            data: "Original Amount:",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w600,
                            color: AppColor.white,
                          ),
                          Obx(
                            () => AppText(
                              data:
                                  "\$${controller.totalAmount.toStringAsFixed(2)}",
                              fontSize: AppSize.width(value: 16),
                              fontWeight: FontWeight.w500,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      Gap(height: AppSize.size.height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: AppColor.blue500,
                        ),
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: Row(
                          spacing: AppSize.width(value: 4),
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppImage(
                              path: AssetsPath.gift,
                              width: AppSize.width(value: 12),
                            ),
                            AppText(
                              data: "No rewards available at the moment",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                          ],
                        ),
                      ),
                      Gap(height: AppSize.size.height * 0.01),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: AppColor.blue500,
                        ),
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: Row(
                          spacing: AppSize.width(value: 4),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppText(
                              data: "Final Amount:",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                              color: AppColor.white,
                            ),
                            Obx(
                              () => AppText(
                                data:
                                    "\$${controller.totalAmount.toStringAsFixed(2)}",
                                fontSize: AppSize.width(value: 12),
                                fontWeight: FontWeight.w700,
                                color: AppColor.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(height: AppSize.size.height * 0.01),
                      AppText(
                        data:
                            "Shipping and/or processing fees to be added on the final invoice",
                        fontSize: AppSize.width(value: 12),
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                      ),
                      Gap(height: AppSize.size.height * 0.01),
                      AppText(
                        data: "Terms",
                        fontSize: AppSize.width(value: 18),
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                      Gap(height: AppSize.size.height * 0.01),
                      Obx(
                        () => CustomDropdown(
                          items: controller.paymentTerms,
                          selectedValue: controller.selectedTerm.value,
                          hint: "Due on Receipt",
                          onChanged: (value) =>
                              controller.updateSelectedTerm(value),
                        ),
                      ),
                      Gap(height: AppSize.size.height * 0.025),
                      Obx(
                        () => AppButton(
                          title: controller.isPlacingOrder.value
                              ? "Placing Order..."
                              : "Place Order",
                          filColor: Color(0xff03DAC5),
                          onTap: controller.isPlacingOrder.value
                              ? null
                              : () => controller.placeOrder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class ShoppingCard extends StatelessWidget {
  final CartItemModel cartItem;
  final RetailerShoppingCartController controller;

  const ShoppingCard({
    super.key,
    required this.cartItem,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSize.size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.width(value: 16)),
          border: Border.all(color: AppColor.black.withValues(alpha: 0.1)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 16),
          vertical: AppSize.width(value: 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSize.size.height * 0.01,
          children: [
            buildRowItem("Product Name", cartItem.product.name),
            buildRowItem("Product Size", cartItem.product.size),
            buildRowItem("Per Box Qty", "${cartItem.product.perBoxQty}"),
            buildRowItem("Product Price", "\$${cartItem.product.price}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: "Box Count",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Minus button
                      InkWell(
                        onTap: () {
                          controller.decrementItem(cartItem.product.id);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 12),
                            vertical: AppSize.width(value: 8),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.width(value: 8)),
                              bottomLeft: Radius.circular(
                                AppSize.width(value: 8),
                              ),
                            ),
                            color: AppColor.white,
                          ),

                          child: Icon(
                            Icons.remove,
                            size: AppSize.width(value: 18),
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      // Quantity display
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 12),
                          vertical: AppSize.width(value: 6),
                        ),
                        decoration: BoxDecoration(color: AppColor.white),
                        child: Obx(
                          () => AppText(
                            data: "${cartItem.quantity.value}",
                            fontSize: 16,
                            color: AppColor.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Plus button
                      InkWell(
                        onTap: () {
                          controller.incrementItem(cartItem.product.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                AppSize.width(value: 8),
                              ),
                              bottomRight: Radius.circular(
                                AppSize.width(value: 8),
                              ),
                            ),
                            color: AppColor.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 12),
                            vertical: AppSize.width(value: 8),
                          ),

                          child: Icon(
                            Icons.add,
                            size: AppSize.width(value: 18),
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            buildRowItem(
              "Total Amount",
              "\$${cartItem.totalPrice.toStringAsFixed(2)}",
            ),
            // Calling the private method here
          ],
        ),
      ),
    );
  }

  Widget buildRowItem(String? title, String? subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: title ?? "No Text",
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w600,
          color: AppColor.black,
        ),
        AppText(
          data: subtitle ?? "No Text",
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w400,
          color: AppColor.black,
        ),
      ],
    );
  }
}
