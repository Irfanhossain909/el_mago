import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/retailer_select_extrabox_screen/controller/retailer_select_extrabox_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerSelectExtraboxScreen extends StatelessWidget {
  const RetailerSelectExtraboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RetailerSelectExtraboxController>(
      init: RetailerSelectExtraboxController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: "Select Extra Boxes"),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: Column(
              spacing: AppSize.size.height * 0.01,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    border: Border.all(color: Colors.blue, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    spacing: AppSize.size.height * 0.007,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppText(
                            data: "Current Tier:",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w700,
                          ),
                          AppText(
                            data: " Platinum",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AppText(
                            data: "Minimum Boxes Required:",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w700,
                          ),
                          AppText(
                            data: "  6",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AppText(
                            data: "Subscription: Platinum Tier:",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w700,
                          ),
                          AppText(
                            data: "  6 boxes per month",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      AppText(
                        data:
                            "Select products for your subscription and adjust quantities as needed.",
                        fontSize: AppSize.width(value: 12),
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                AppText(
                  data: "Available Products",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w700,
                ),

                Obx(() {
                  return GridView.builder(
                    shrinkWrap: true, // Column এর মধ্যে রাখতে হলে দরকার
                    physics:
                        NeverScrollableScrollPhysics(), // Nested scroll issue fix
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // প্রতি row-তে কয়টা column থাকবে
                      mainAxisSpacing: AppSize.width(value: 12), // row gap
                      crossAxisSpacing: AppSize.width(value: 12), // column gap
                      childAspectRatio:
                          1.7, // card এর width-height ratio নিয়ন্ত্রণ করবে
                    ),
                    itemCount: controller
                        .getAllProducts
                        .length, // আপনার product list length দিন
                    itemBuilder: (context, index) {
                      final product = controller.getAllProducts[index];
                      return ExtraBoxCard(
                        title: product.name,
                        title2: product.size,
                        price: product.price.toString(),
                      );
                    },
                  );
                }),

                AppText(
                  data: "Selected Products",
                  fontSize: AppSize.width(value: 20),
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                //  Obx(() {
                //     return ListView.builder(
                //       padding: EdgeInsets.only(top: AppSize.size.height * 0.02),
                //       shrinkWrap: true,
                //       physics: NeverScrollableScrollPhysics(),
                //       itemCount: controller.getAllProducts.length,
                //       itemBuilder: (context, index) {
                //         final product = controller.getAllProducts[index];
                //         return ProductInformationCard(
                //           onTap: () {
                //             // cartController.addProductToCart(product);
                //             // Get.snackbar(
                //             //   duration: const Duration(seconds: 1),
                //             //   snackPosition: SnackPosition.TOP,
                //             //   "Product Added",
                //             //   "${product.name} has been added to cart",
                //             // );
                //           },
                //           product: product,
                //         );
                //       },
                //     );
                //   }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ExtraBoxCard extends StatelessWidget {
  final bool isSelected;
  final String? title;
  final String? title2;
  final String? price;
  const ExtraBoxCard({
    super.key,
    this.title,
    this.title2,
    this.price,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withValues(alpha: 0.1) : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(AppSize.width(value: 8)),
      child: Row(
        spacing: AppSize.size.height * 0.01,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black),
            ),
          ),

          Expanded(
            child: Column(
              spacing: AppSize.size.height * 0.007,
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
