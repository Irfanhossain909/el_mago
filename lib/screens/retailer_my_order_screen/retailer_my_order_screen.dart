import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/models/retailer_order/retailer_order_model.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/retailer_my_order_screen/controller/retailer_my_order_screen_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_circle_card/circle_icon_with_bg.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class RetailerMyOrderScreen extends StatelessWidget {
  const RetailerMyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerMyOrderController controller =
        Get.find<RetailerMyOrderController>();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'My Order',
        autoShowLeading: false,
        action: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: CircleIconWithBg(onTap: () {}, path: AssetsPath.filter),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppInputWidgetTwo(
              controller: controller.searchController,
              borderColor: AppColor.button,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 12.0,
              ),
              hintText: "Search by Invoice ID or Product Name",
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredOrderList.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: controller.refreshOrders,
                    child: ListView(
                      children: const [
                        SizedBox(height: 200),
                        Center(child: Text("No orders found.")),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: controller.refreshOrders,
                  child: ListView.builder(
                    // Attach the scroll controller
                    controller: controller.scrollController,
                    // Adjust item count for loading indicator
                    itemCount:
                        controller.filteredOrderList.length +
                        (controller.isLoadingMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Show loading indicator at the bottom
                      if (index == controller.filteredOrderList.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final order = controller.filteredOrderList[index];
                      return ViewOrderCard(
                        order: order,
                        onTap: () {
                          controller.viewOrderDetails(order.id);
                          Get.toNamed(
                            AppRoutes.instance.retailerOrderDetailsScreen,
                            arguments: order.id, // Pass order ID as arguments
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewOrderCard extends StatelessWidget {
  final RetailerOrderModel order;
  final VoidCallback? onTap;
  const ViewOrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSize.size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.width(value: 16)),
          border: Border.all(color: AppColor.black.withOpacity(0.1)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 16),
          vertical: AppSize.width(value: 12),
        ),
        child: Column(
          children: [
            buildOrderDetails(title: "Invoice#", value: order.orderId),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(title: "Address", value: order.shippingAddress),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(
              title: "Order date",
              value: order.formattedCreatedAt,
            ),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(
              title: "Order Quantity",
              value: order.totalQuantity.toString(),
            ),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(
              title: "Reward Name",
              value: order.rewardDisplayName,
            ),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(title: "Reward", value: order.rewardDisplayValue),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(
              title: "Amount",
              value: "\$${order.totalAmount.toStringAsFixed(2)}",
            ),
            Gap(height: AppSize.size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.width(value: 6),
                      ),
                      color: AppColor.blue,
                    ),
                    child: AppText(
                      data: "View Details",
                      fontSize: AppSize.width(value: 16),
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderDetails({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: title,
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w600,
          color: AppColor.black,
        ),
        AppText(
          data: value,
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w400,
          color: AppColor.black,
        ),
      ],
    );
  }
}
