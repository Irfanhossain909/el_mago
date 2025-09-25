import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/sales_dash_board/controller/sales_dashboard_controller.dart';
import 'package:el_mago/screens/sales_dash_board/widget/product_information_card.dart';
import 'package:el_mago/screens/sales_shopping_cart/controller/sales_shopping_cart_controller.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_text/custom_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesDashBoardScreen extends StatelessWidget {
  const SalesDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SalesDashboardController controller =
        Get.find<SalesDashboardController>();

    final SalesShoppingCartController cartController =
        Get.find<SalesShoppingCartController>();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Dashboard Overview',
        autoShowLeading: true,
        action: [
          CircleAvatar(
            backgroundColor: AppColor.blue,
            child: IconButton(
              onPressed: () =>
                  Get.toNamed(AppRoutes.instance.salesShoppingCartScreen),
              icon: Image.asset(
                AssetsPath.cart,
                color: AppColor.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: AppColor.blue,
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                AssetsPath.notification,
                color: AppColor.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppInputWidgetTwo(
                controller: controller.searchController,
                borderColor: AppColor.button,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12.0,
                ),
                hintText: "Search by Product Name",
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  if (controller.globalController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.filteredProductList.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: "No products found.",
                        fontSize: 16,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.filteredProductList.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProductList[index];
                      return ProductInformationCard(
                        product: product,
                        onTap: () {
                          cartController.addProductToCart(product);
                          Get.snackbar(
                            duration: const Duration(seconds: 1),
                            snackPosition: SnackPosition.TOP,
                            "Product Added",
                            "${product.name} has been added to cart",
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
