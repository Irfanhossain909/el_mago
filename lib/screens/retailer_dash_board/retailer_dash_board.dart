import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/retailer_dash_board/controller/retailer_dash_board_controller.dart';
import 'package:el_mago/screens/retailer_shopping_cart/controller/retailer_shopping_cart_controller.dart';
import 'package:el_mago/screens/sales_dash_board/widget/product_information_card.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_circle_card/circle_icon_with_bg.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerDashBoard extends StatelessWidget {
  const RetailerDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerDashBoardController controller =
        Get.find<RetailerDashBoardController>();
    final RetailerShoppingCartController cartController =
        Get.find<RetailerShoppingCartController>();
    return Scaffold(
      appBar: CustomAppbar(
        autoShowLeading: false,
        title: "Dashboard Overview",
        action: [
          CircleIconWithBg(
            onTap: () {
              Get.toNamed(AppRoutes.instance.retailerShoppingCartScreen);
            },
            path: AssetsPath.cart,
          ),
          Gap(width: AppSize.width(value: 8)),
          CircleIconWithBg(
            onTap: () {
              Get.toNamed(AppRoutes.instance.notificationScreen);
            },
            path: AssetsPath.notification,
          ),
          Gap(width: AppSize.width(value: 8)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshAllData(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.width(value: 16)),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  spacing: AppSize.width(value: 12),
                  children: [
                    Expanded(
                      child: Obx(() {
                        final summary = controller.dashboardSummary.value;
                        return RetailerDataCard(
                          path: AssetsPath.dollerColor,
                          title: summary != null
                              ? "\$${summary.totalPurchaseAmount}"
                              : "\$0",
                          subTitle: "Total Purchased",
                        );
                      }),
                    ),
                    Expanded(
                      child: Obx(() {
                        final summary = controller.dashboardSummary.value;
                        return RetailerDataCard(
                          path: AssetsPath.cartColor,
                          title: summary != null
                              ? "${summary.totalOrderCompleate}"
                              : "0",
                          subTitle: "Total Orders Placed",
                        );
                      }),
                    ),
                  ],
                ),
                Obx(() {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: AppSize.size.height * 0.02),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.getAllProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.getAllProducts[index];
                      return ProductInformationCard(
                        onTap: () {
                          cartController.addProductToCart(product);

                          Get.snackbar(
                            duration: const Duration(seconds: 1),
                            snackPosition: SnackPosition.TOP,
                            "Product Added",
                            "${product.name} has been added to cart",
                          );
                        },
                        product: product,
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RetailerDataCard extends StatelessWidget {
  final String? path;
  final String? title;
  final String? subTitle;

  const RetailerDataCard({super.key, this.path, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.blue,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(value: 8),
        vertical: AppSize.width(value: 12),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSize.width(value: 8),
        children: [
          Container(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.width(value: 32)),
              color: AppColor.white,
            ),
            child: AppImage(
              path: path ?? AssetsPath.cartColor,
              width: AppSize.width(value: 28),
            ),
          ),
          Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: title ?? r"$0.00",
                fontSize: AppSize.width(value: 20),
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
              AppText(
                data: subTitle ?? "Total Purchased",
                fontSize: AppSize.width(value: 12),
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
