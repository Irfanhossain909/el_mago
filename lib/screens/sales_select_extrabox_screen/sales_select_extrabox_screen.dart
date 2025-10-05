import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/sales_select_extrabox_screen/controller/sales_select_extrabox_screen_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesSelectExtraboxScreen extends StatelessWidget {
  const SalesSelectExtraboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SalesSelectExtraboxScreenController>(
      init: SalesSelectExtraboxScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: "Select Extra Boxes"),
          // NEW: Added bottom navigation bar for the summary
          bottomNavigationBar: controller.cart.isEmpty
              ? const SizedBox.shrink() // Hide if cart is empty
              : SalesBottomSummaryBar(controller: controller),
          body: SingleChildScrollView(
            // NEW: Made the body scrollable
            child: Padding(
              padding: EdgeInsets.all(AppSize.width(value: 12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- This is your existing code for the top section ---
                  Obx(
                    () => controller.isLoadingSubscription.value
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: .1),
                              border: Border.all(
                                color: Colors.blue,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: .1),
                              border: Border.all(
                                color: Colors.blue,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppText(
                                      data: "Current Tier:",
                                      fontSize: AppSize.width(value: 12),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    Obx(
                                      () => AppText(
                                        data: " ${controller.currentTier}",
                                        fontSize: AppSize.width(value: 12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSize.size.height * 0.007),
                                Row(
                                  children: [
                                    AppText(
                                      data: "Minimum Boxes Required:",
                                      fontSize: AppSize.width(value: 12),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    Obx(
                                      () => AppText(
                                        data: "  ${controller.minimumBoxes}",
                                        fontSize: AppSize.width(value: 12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSize.size.height * 0.007),
                                Row(
                                  children: [
                                    AppText(
                                      data:
                                          "Subscription: ${controller.currentTier} Tier:",
                                      fontSize: AppSize.width(value: 12),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    Obx(
                                      () => AppText(
                                        data:
                                            "  ${controller.subscriptionTier}",
                                        fontSize: AppSize.width(value: 12),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: AppSize.size.height * 0.007),
                                AppText(
                                  data:
                                      "Select products for your customer's subscription and adjust quantities as needed.",
                                  fontSize: AppSize.width(value: 12),
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: AppSize.size.height * 0.01),
                  AppText(
                    data: "Available Products",
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: AppSize.size.height * 0.01),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSize.width(value: 12),
                      crossAxisSpacing: AppSize.width(value: 12),
                      childAspectRatio: 1.7,
                    ),
                    itemCount: controller.getAllProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.getAllProducts[index];
                      return SalesExtraBoxCard(
                        title: product.name,
                        title2: product.size,
                        price: product.price.toString(),
                        // UPDATED: Linking card state to controller
                        isSelected: controller.isProductInCart(product),
                        onChanged: (value) {
                          controller.toggleProductSelection(product);
                        },
                      );
                    },
                  ),
                  SizedBox(height: AppSize.size.height * 0.02),
                  AppText(
                    data: "Selected Products",
                    fontSize: AppSize.width(value: 20),
                    fontWeight: FontWeight.w700,
                    color: AppColor.black,
                  ),

                  // --- NEW: SELECTED PRODUCTS LIST ---
                  if (controller.cart.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(child: Text("No products selected yet.")),
                    )
                  else
                    ListView.builder(
                      padding: EdgeInsets.only(top: AppSize.size.height * 0.02),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.cart.length,
                      itemBuilder: (context, index) {
                        final cartItem = controller.cart[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: SalesSelectedProductCard(
                            cartItem: cartItem,
                            controller: controller,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// SLIGHTLY MODIFIED: Changed the box to an interactive Checkbox
class SalesExtraBoxCard extends StatelessWidget {
  final String? title;
  final String? title2;
  final String? price;
  final bool isSelected;
  final ValueChanged<bool?>? onChanged; // Added callback

  const SalesExtraBoxCard({
    super.key,
    this.title,
    this.title2,
    this.price,
    this.isSelected = false,
    this.onChanged, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withValues(alpha: .1) : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(AppSize.width(value: 4)),
      child: Row(
        children: [
          Checkbox(
            // Changed to a real checkbox
            value: isSelected,
            onChanged: onChanged,
            activeColor: AppColor.blue,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  data: title ?? "no text",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                AppText(
                  data: title2 ?? "no text",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
                AppText(
                  data: "\$$price",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w500,
                  color: AppColor.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- NEW WIDGETS ---

// NEW WIDGET: Card for a single selected product in the cart list.
class SalesSelectedProductCard extends StatelessWidget {
  final SalesCartItem cartItem;
  final SalesSelectExtraboxScreenController controller;

  const SalesSelectedProductCard({
    super.key,
    required this.cartItem,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow("Product", product.name),
          _buildInfoRow("Size", product.size),
          _buildInfoRow("Unit Price", "\$${product.price}"),
          _buildQuantityRow(),
          const Divider(height: 24),
          Obx(
            () => _buildInfoRow(
              "Total Price",
              "\$${(product.price * cartItem.quantity.value).toStringAsFixed(2)}",
              isTotal: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            data: label,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: Colors.black,
          ),
          AppText(
            data: value,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            data: "Quantity",
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 16),
                  onPressed: () => controller.decrementQuantity(cartItem),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                Obx(
                  () => AppText(
                    data: "${cartItem.quantity.value}",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 16),
                  onPressed: () => controller.incrementQuantity(cartItem),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// NEW WIDGET: The purple bottom summary bar.
class SalesBottomSummaryBar extends StatelessWidget {
  final SalesSelectExtraboxScreenController controller;

  const SalesBottomSummaryBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.deepPurpleAccent, // Indigo/Purple Color
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => _buildSummaryRow(
              "Selected:",
              "${controller.totalSelectedProducts} products",
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => _buildSummaryRow("Total Boxes:", "${controller.totalBoxes}"),
          ),
          const SizedBox(height: 8),
          Obx(
            () => _buildSummaryRow(
              "Total Amount:",
              "\$${controller.totalAmount.toStringAsFixed(2)}",
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Clear the cart
                    controller.cart.clear();
                    Get.snackbar(
                      "Cancelled",
                      "Selection cleared",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xff721af0),
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isPlacingOrder.value
                        ? null
                        : () async {
                            await controller.placeOrder();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff03dac5), // Teal Color
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: controller.isPlacingOrder.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Save Selection",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(data: label, color: Colors.white, fontWeight: FontWeight.w700),
        AppText(data: value, color: Colors.white, fontWeight: FontWeight.bold),
      ],
    );
  }
}
