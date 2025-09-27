import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/models/order_model/order_model.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/sales_my_order/controller/sales_my_order_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_circle_card/circle_icon_with_bg.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesMyOrderScreen extends StatelessWidget {
  const SalesMyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesMyOrderController controller =
        Get.find<SalesMyOrderController>();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'My Order',
        autoShowLeading: true,
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
                    onRefresh: () async {
                      controller.fetchMyOrders();
                    },
                    child: const SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text("No orders found."),
                        ),
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchMyOrders();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.filteredOrderList.length,
                    itemBuilder: (context, index) {
                      final order = controller.filteredOrderList[index];
                      return SalesViewOrderCard(
                        order: order,
                        onTap: () {
                          controller.viewOrderDetails(order);
                          Get.toNamed(
                            AppRoutes.instance.salesOrderDetailsScreen,
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

class SalesViewOrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;
  const SalesViewOrderCard({super.key, required this.order, this.onTap});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildOrderDetails(title: "Invoice#", value: order.orderId),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(
              title: "Retailer Name",
              value: order.userId.name,
            ), // Note: Retailer name not available in this API
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
              title: "Amount",
              value: "\$${order.totalAmount.toStringAsFixed(2)}",
            ),
            Gap(height: AppSize.size.height * 0.01),
            buildOrderDetails(
              title: "Status",
              value: order.orderStatus.capitalizeFirst ?? '',
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
