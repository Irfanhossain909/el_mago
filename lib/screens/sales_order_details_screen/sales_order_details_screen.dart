import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/models/order_model/order_model.dart';
import 'package:el_mago/screens/sales_order_details_screen/controller/sales_order_details_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesOrderDetailsScreen extends StatelessWidget {
  const SalesOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesOrderDetailsController controller =
        Get.find<SalesOrderDetailsController>();

    return Scaffold(
      appBar: CustomAppbar(title: 'Order Details', autoShowLeading: true),
      body: Obx(() {
        final order = controller.order.value;
        if (order == null) {
          return const Center(child: Text("Order details not found."));
        }
        return Padding(
          padding: EdgeInsets.all(AppSize.width(value: 12)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(order),
                Gap(height: AppSize.size.height * 0.01),
                _buildCustomerInfo(order),
                Gap(height: AppSize.size.height * 0.01),
                _buildOrderSummary(order),
                Gap(height: AppSize.size.height * 0.01),
                _buildOrderItems(order),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(OrderModel order) {
    return Container(
      padding: EdgeInsets.all(AppSize.width(value: 12)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.blue,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: "Order ID",
                fontSize: AppSize.width(value: 12),
                color: AppColor.white,
              ),
              Gap(height: AppSize.size.height * 0.005),
              AppText(
                data: order.orderId,
                fontSize: AppSize.width(value: 16),
                color: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const Spacer(),
          AppText(
            data: order.orderStatus.capitalizeFirst ?? '',
            fontSize: AppSize.width(value: 18),
            color: AppColor.white,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(OrderModel order) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        border: Border.all(color: AppColor.black.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 18)),
            child: AppText(
              data: "Customer Information",
              fontSize: AppSize.width(value: 18),
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
          Divider(
            color: AppColor.black.withOpacity(0.1),
            thickness: AppSize.width(value: 1),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: SalesOrderDetailsRowCard(
              iconPath: AssetsPath.person,
              title: "Customer Name",
              subTitle: order
                  .userId
                  .name, // Note: Customer name is not in the order API response
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              color: AppColor.black.withOpacity(0.2),
              thickness: AppSize.width(value: 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: SalesOrderDetailsRowCard(
              iconPath: AssetsPath.addressCard,
              title: "Address",
              subTitle: order.shippingAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              color: AppColor.black.withOpacity(0.2),
              thickness: AppSize.width(value: 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: SalesOrderDetailsRowCard(
              iconPath: AssetsPath.calender,
              title: "Order terms",
              subTitle: order.orderTerms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(OrderModel order) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
        border: Border.all(color: AppColor.black.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 18)),
            child: AppText(
              data: "Order Summary",
              fontSize: AppSize.width(value: 18),
              fontWeight: FontWeight.w600,
              color: AppColor.black,
            ),
          ),
          const Divider(color: AppColor.black, thickness: 1),
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: SalesOrderDetailsRowCard(
              iconPath: AssetsPath.box,
              title: "Total Boxes",
              subTitle: order.orderBoxs.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              color: AppColor.black.withOpacity(0.3),
              thickness: AppSize.width(value: 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: Row(
              children: [
                AppImage(
                  path: AssetsPath.currency,
                  width: AppSize.width(value: 24),
                ),
                Gap(width: AppSize.width(value: 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(data: "Total Price"),
                      Gap(height: AppSize.width(value: 6)),
                      AppText(
                        data: "\$${order.totalAmount.toStringAsFixed(2)}",
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w700,
                      ),
                      Gap(height: AppSize.width(value: 6)),
                      const AppText(
                        data:
                            "Shipping and/or processing fees to be added on the final invoice",
                        fontSize: 12,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Divider(
              color: AppColor.black.withOpacity(0.3),
              thickness: AppSize.width(value: 1),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: Row(
              children: [
                AppImage(
                  path: AssetsPath.currency,
                  width: AppSize.width(value: 24),
                ),
                Gap(width: AppSize.width(value: 10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(data: "Commission"),
                    Gap(height: AppSize.width(value: 6)),
                    AppText(
                      data: "${order.commission}%",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(OrderModel order) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.white,
        border: Border.all(color: AppColor.black.withOpacity(0.2)),
      ),
      padding: EdgeInsets.all(AppSize.width(value: 12)),
      child: Column(
        children: [
          Row(
            children: [
              AppImage(path: AssetsPath.tag, width: AppSize.width(value: 16)),
              Gap(width: AppSize.width(value: 8)),
              AppText(
                data: "Order Items",
                fontSize: AppSize.width(value: 16),
                color: AppColor.black,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          Gap(height: AppSize.size.height * 0.01),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.products.length,
            itemBuilder: (context, index) {
              final product = order.products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  children: [
                    salesBuildOrderDetailsRowCard(
                      title: "Product Name",
                      value: product.name,
                    ),
                    Gap(height: AppSize.size.height * 0.01),
                    salesBuildOrderDetailsRowCard(
                      title: "Order Quantity",
                      value: product.quantity.toString(),
                    ),
                    Gap(height: AppSize.size.height * 0.01),
                    salesBuildOrderDetailsRowCard(
                      title: "BackOrder",
                      value: product.backOrder.toString(),
                    ),
                    Gap(height: AppSize.size.height * 0.01),
                    salesBuildOrderDetailsRowCard(
                      title: "Price (per unit)",
                      value: "\$${product.price.toStringAsFixed(2)}",
                    ),
                    Gap(height: AppSize.size.height * 0.01),
                    salesBuildOrderDetailsRowCard(
                      title: "Total",
                      value: "\$${product.totalAmount.toStringAsFixed(2)}",
                    ),
                    if (index < order.products.length - 1)
                      const Divider(height: 24),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget salesBuildOrderDetailsRowCard({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: title,
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w600,
        ),
        AppText(
          data: value,
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

class SalesOrderDetailsRowCard extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? iconPath;
  const SalesOrderDetailsRowCard({
    super.key,
    this.title,
    this.subTitle,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          path: iconPath ?? AssetsPath.addressCard,
          width: AppSize.width(value: 24),
        ),
        Gap(width: AppSize.width(value: 10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: title ?? "No Text",
                fontSize: AppSize.width(value: 12),
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
              Gap(height: AppSize.width(value: 6)),
              AppText(
                data: subTitle ?? "No Text",
                fontSize: AppSize.width(value: 16),
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
