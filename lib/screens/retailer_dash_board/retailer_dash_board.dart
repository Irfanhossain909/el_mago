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
import 'package:fluttertoast/fluttertoast.dart';
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
          Stack(
            children: [
              CircleIconWithBg(
                onTap: () {
                  controller.notificationCount.value = 0;
                  Get.toNamed(AppRoutes.instance.notificationScreen);
                },
                path: AssetsPath.notification,
              ),
              if (controller.notificationCount.value > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
          Gap(width: AppSize.width(value: 8)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshAllData(),
        child: Padding(
          padding: EdgeInsets.all(AppSize.width(value: 16)),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  controller.hasMore.value &&
                  !controller.isLoadingMore.value) {
                controller.loadMoreProducts();
              }
              return false;
            },
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
                    if (controller.isLoading.value &&
                        controller.getAllProducts.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: AppSize.size.height * 0.02,
                        ),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.only(top: AppSize.size.height * 0.02),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          controller.getAllProducts.length +
                          (controller.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Show loading indicator at the bottom
                        if (index == controller.getAllProducts.length) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final product = controller.getAllProducts[index];
                        return ProductInformationCard(
                          onTap: () {
                            cartController.addProductToCart(product);
                            showCustomToast(
                              context,
                              "${product.name} added to cart",
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

void showCustomToast(BuildContext context, String message) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: Colors.green.shade600,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: const Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.white, size: 20),
        const SizedBox(width: 12.0),
        Flexible(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 1),
  );
}
