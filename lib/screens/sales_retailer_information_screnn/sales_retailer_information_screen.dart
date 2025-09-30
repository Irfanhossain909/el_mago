import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/retailer_dash_board/retailer_dash_board.dart';
import 'package:el_mago/screens/sales_retailer_information_screnn/controller/sales_retailer_info_controller.dart';
import 'package:el_mago/screens/sales_retailer_information_screnn/widget/retailer_card_data.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesRetailerInformationScreen extends StatelessWidget {
  const SalesRetailerInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesRetailerInfoController>(
      init: SalesRetailerInfoController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: "Retailer Information"),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: AppSize.size.height * 0.02,
              children: [
                // Credit Card Style Container
                Obx(() {
                  return RetailerCardData(
                    cardNumber:
                        controller.retailerCardData.value?.card?.cardNumber,
                    cvv: controller.retailerCardData.value?.card?.cvv,
                    name:
                        controller.retailerCardData.value?.card?.cardHolderName,
                    expires:
                        controller.retailerCardData.value?.card?.expiryDate,
                    zipCode: controller.retailerCardData.value?.card?.zipCode,
                  );
                }),
                Obx(() {
                  return Row(
                    spacing: AppSize.width(value: 12),
                    children: [
                      Expanded(
                        child: RetailerDataCard(
                          path: AssetsPath.cartColor,
                          title: controller.retailerCardData.value?.totalSales
                              .toString(),
                          subTitle: "Total Sales",
                        ),
                      ),
                      Expanded(
                        child: RetailerDataCard(
                          path: AssetsPath.cartColor,
                          title: controller.retailerCardData.value?.totalOrders
                              .toString(),
                          subTitle: "Total Orders",
                        ),
                      ),
                    ],
                  );
                }),
                Obx(() {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      border: Border.all(color: Colors.blue, width: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      spacing: AppSize.size.height * 0.007,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          data: "Business Information",
                          fontSize: AppSize.width(value: 20),
                          fontWeight: FontWeight.w700,
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "testing retailer",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              data: " ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "ID:  ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              data:
                                  controller
                                      .retailerCardData
                                      .value
                                      ?.retailerInfo
                                      ?.id ??
                                  "--:--",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Email:  ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              data:
                                  controller
                                      .retailerCardData
                                      .value
                                      ?.retailerInfo
                                      ?.email ??
                                  "--:--",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Phone:  ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              data:
                                  controller
                                      .retailerCardData
                                      .value
                                      ?.retailerInfo
                                      ?.phone ??
                                  "--:--",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Address:  ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              data:
                                  controller
                                      .retailerCardData
                                      .value
                                      ?.retailerInfo
                                      ?.address ??
                                  "--:--",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Assigned Sales Rep:  ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              data:
                                  controller
                                      .retailerCardData
                                      .value
                                      ?.retailerInfo
                                      ?.assignedSalesRep
                                      ?.name ??
                                  "--:--",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppText(
                              data: "Sales Rep Email:  ",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              data:
                                  controller
                                      .retailerCardData
                                      .value
                                      ?.retailerInfo
                                      ?.assignedSalesRep
                                      ?.name ??
                                  "--:--",
                              fontSize: AppSize.width(value: 12),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
