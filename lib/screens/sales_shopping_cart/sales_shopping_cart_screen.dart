import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/sales_shopping_cart/controller/sales_shopping_cart_controller.dart';
import 'package:el_mago/screens/sales_shopping_cart/widgets/sales_shopping_cart_card.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/app_text/custom_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesShoppingCartScreen extends StatelessWidget {
  const SalesShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesShoppingCartController controller =
        Get.find<SalesShoppingCartController>();

    return Scaffold(
      appBar: CustomAppbar(title: 'Shopping Cart', autoShowLeading: true),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(
            child: Text(
              'Your Cart is Empty',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return Column(
          children: [
            // List of Cart Items
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(value: 20),
                ),
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return ShoppingCartItemCard(
                    cartItem: item,
                    onIncrement: () => controller.incrementQuantity(item),
                    onDecrement: () => controller.decrementQuantity(item),
                  );
                },
              ),
            ),
            // Order Details Section
            Container(
              padding: EdgeInsets.all(AppSize.width(value: 20)),
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    data: "Order Details",
                    color: AppColor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: AppSize.height(value: 20)),
                  // These can be replaced with actual dropdowns and text fields later
                  _buildRetailerDropdown(controller),
                  SizedBox(height: AppSize.height(value: 15)),
                  _buildPlaceholderInput("Due on Receipt"),
                  SizedBox(height: AppSize.height(value: 15)),
                  _buildPlaceholderInput("Enter Notes", maxLines: 3),
                  SizedBox(height: AppSize.height(value: 20)),
                  const AppText(
                    data: "Shopping Cart",
                    color: AppColor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: AppSize.height(value: 15)),
                  _buildSummaryRow(
                    "Total Box:",
                    controller.totalBox.toString(),
                  ),
                  SizedBox(height: AppSize.height(value: 10)),
                  _buildSummaryRow(
                    "Total Amount:",
                    "\$${controller.totalAmount.toStringAsFixed(2)}",
                  ),
                  SizedBox(height: AppSize.height(value: 20)),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.removeAllItems,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColor.white),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const AppText(
                            data: "Remove All",
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSize.width(value: 15)),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            /* Handle Place Order Later */
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: AppText(
                            data: "Place Order",
                            color: AppColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRetailerDropdown(SalesShoppingCartController controller) {
    return Obx(() {
      if (controller.isRetailerLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: controller.selectedRetailerId.value,
            isExpanded: true,
            hint: const AppText(data: "Select Retailer", color: AppColor.white),
            icon: const Icon(Icons.arrow_drop_down, color: AppColor.white),
            dropdownColor: AppColor.blue,
            items: controller.retailers.map((retailer) {
              return DropdownMenuItem<String>(
                value: retailer.id,
                child: AppText(data: retailer.name, color: AppColor.white),
              );
            }).toList(),
            onChanged: (newValue) {
              controller.selectRetailer(newValue);
            },
          ),
        ),
      );
    });
  }

  Widget _buildSummaryRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(data: title, color: AppColor.white, fontSize: 16),
        AppText(
          data: value,
          color: AppColor.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _buildPlaceholderInput(String hint, {int maxLines = 1}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(data: hint, color: AppColor.white),
          if (maxLines == 1)
            const Icon(Icons.arrow_drop_down, color: AppColor.white),
        ],
      ),
    );
  }
}
