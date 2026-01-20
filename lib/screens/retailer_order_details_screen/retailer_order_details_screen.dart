import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/retailer_order_details_screen/controller/retailer_order_details_screen_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerOrderDetailsScreen extends StatelessWidget {
  const RetailerOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RetailerOrderDetailsController());

    return Scaffold(
      appBar: CustomAppbar(title: 'Order Details'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.order.value == null) {
          return const Center(child: Text('Order not found or failed to load'));
        }

        final order = controller.order.value!;

        return Padding(
          padding: EdgeInsets.all(AppSize.width(value: 12)),
          child: SingleChildScrollView(
            child: Column(
              spacing: AppSize.size.height * 0.01,
              children: [
                Container(
                  padding: EdgeInsets.all(AppSize.width(value: 12)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.blue,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppSize.size.height * 0.005,
                        children: [
                          AppText(
                            data: "Order ID",
                            fontSize: AppSize.width(value: 12),
                            color: AppColor.white,
                          ),
                          AppText(
                            data: order.orderId,
                            fontSize: AppSize.width(value: 16),
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      Spacer(),
                      AppText(
                        data: order.orderStatus,
                        fontSize: AppSize.width(value: 18),
                        color: AppColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 12),
                    ),
                    border: Border.all(
                      color: AppColor.black.withValues(alpha: 0.2),
                    ),
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
                        color: AppColor.black.withValues(alpha: 0.1),
                        thickness: AppSize.width(value: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: OrderDetailsRowCard(
                          iconPath: AssetsPath.addressCard,
                          title: "Address",
                          subTitle: order.shippingAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                          color: AppColor.black.withValues(alpha: 0.2),
                          thickness: AppSize.width(value: 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: OrderDetailsRowCard(
                          iconPath: AssetsPath.calender,
                          title: "Order Date",
                          subTitle: order.formattedDetailedDate,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 12),
                    ),
                    border: Border.all(
                      color: AppColor.black.withValues(alpha: 0.2),
                    ),
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
                      Divider(
                        color: AppColor.black,
                        thickness: AppSize.width(value: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: OrderDetailsRowCard(
                          iconPath: AssetsPath.box,
                          title: "Total Boxes",
                          subTitle: order.orderBoxs.toString(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                          color: AppColor.black.withValues(alpha: 0.3),
                          thickness: AppSize.width(value: 1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: Row(
                          spacing: AppSize.width(value: 10),
                          children: [
                            AppImage(
                              path: AssetsPath.currency,
                              width: AppSize.width(value: 24),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  data: "Total Price",
                                  fontSize: AppSize.width(value: 12),
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                                Gap(height: AppSize.width(value: 6)),
                                AppText(
                                  data:
                                      "\$${order.totalAmount.toStringAsFixed(2)}",
                                  fontSize: AppSize.width(value: 16),
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black,
                                ),
                                Gap(height: AppSize.width(value: 6)),
                                AppText(
                                  data:
                                      "Shipping and/or processing fees to be added on the final invoice",
                                  fontSize: AppSize.width(value: 12),
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.black.withValues(alpha: 0.2),
                    ),
                  ),
                  padding: EdgeInsets.all(AppSize.width(value: 12)),
                  child: Column(
                    spacing: AppSize.size.height * 0.01,
                    children: [
                      Row(
                        children: [
                          AppImage(
                            path: AssetsPath.tag,
                            width: AppSize.width(value: 16),
                          ),
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
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: order.products.length,
                        itemBuilder: (context, index) {
                          final product = order.products[index];
                          return Column(
                            spacing: AppSize.size.height * 0.01,
                            children: [
                              buildOrderDetailsRowCard(
                                title: "Product Name",
                                value: product.name,
                              ),
                              buildOrderDetailsRowCard(
                                title: "Order Quantity",
                                value: product.quantity.toString(),
                              ),
                              buildOrderDetailsRowCard(
                                title: "BackOrder",
                                value: product.backOrder.toString(),
                              ),
                              buildOrderDetailsRowCard(
                                title: "Price (per unit)",
                                value: "\$${product.price.toStringAsFixed(2)}",
                              ),
                              buildOrderDetailsRowCard(
                                title: "Total",
                                value:
                                    "\$${product.totalAmount.toStringAsFixed(2)}",
                              ),
                              Gap(height: AppSize.size.height * 0.02),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildOrderDetailsRowCard({
    required String? title,
    required String? value,
  }) {
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
          data: value ?? "No Text",
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w400,
          color: AppColor.black,
        ),
      ],
    );
  }
}

class OrderDetailsRowCard extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? iconPath;
  const OrderDetailsRowCard({
    super.key,
    this.title,
    this.subTitle,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSize.width(value: 10),
      children: [
        AppImage(
          path: iconPath ?? AssetsPath.addressCard,
          width: AppSize.width(value: 24),
        ),
        Column(
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
      ],
    );
  }
}
