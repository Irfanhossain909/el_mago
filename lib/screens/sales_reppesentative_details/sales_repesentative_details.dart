import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/retailer_dash_board/retailer_dash_board.dart';
import 'package:el_mago/screens/sales_reppesentative_details/controller/sales_representative_details_controller.dart';
import 'package:el_mago/screens/sales_reppesentative_details/widget/sales_representative_history.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_formetter/app_formetter.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_image/app_image_circular.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SalesReppesentativeDetails extends StatelessWidget {
  const SalesReppesentativeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesRepresentativeDetailsController>(
      init: SalesRepresentativeDetailsController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: "Retailer Details"),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSize.size.height * 0.015,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColor.black.withValues(alpha: 0.1),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Obx(() {
                      return Row(
                        children: [
                          AppImageCircular(
                            width: 88,
                            height: 88,
                            url:
                                controller.retailerModel.value?.image ??
                                "https://cdn.pixabay.com/photo/2025/09/04/07/47/portrait-9814955_640.jpg",
                          ),
                          Gap(width: AppSize.width(value: 12)),
                          Column(
                            spacing: AppSize.size.height * 0.005,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                data:
                                    controller.retailerModel.value?.name ??
                                    "no text",
                                fontSize: AppSize.width(value: 14),
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                              AppText(
                                data:
                                    controller.retailerModel.value?.email ??
                                    "no text",
                                fontSize: AppSize.width(value: 10),
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                              ),
                              AppText(
                                data:
                                    controller.retailerModel.value?.address ??
                                    "no text",
                                fontSize: AppSize.width(value: 10),
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                              ),
                            ],
                          ),

                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(value: 8),
                              vertical: AppSize.width(value: 6),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColor.blue500),
                            ),
                            child: Row(
                              spacing: AppSize.width(value: 12),
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes
                                          .instance
                                          .salesRetailerInformationScreen,
                                    );
                                  },
                                  child: AppImage(
                                    width: AppSize.width(value: 20),
                                    path: AssetsPath.eyeIcon,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: AppImage(
                                    width: AppSize.width(value: 20),
                                    path: AssetsPath.editIcon,
                                    iconColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),

                  Row(
                    spacing: AppSize.width(value: 12),
                    children: [
                      Expanded(
                        child: RetailerDataCard(
                          path: AssetsPath.dollerColor,
                          title: "0",
                          subTitle: "Total Orders Placed",
                        ),
                      ),
                      Expanded(
                        child: RetailerDataCard(
                          path: AssetsPath.boxColor,
                          title: "0",

                          subTitle: "Total Orders Placed",
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: AppSize.width(value: 12),
                    children: [
                      Expanded(
                        child: ItemCard(
                          text2: controller.retailerModel.value?.address,

                          iconPath: AssetsPath.icLocation,
                        ),
                      ),
                      Expanded(
                        child: ItemCard(
                          iconPath: AssetsPath.icCalender,
                          text1: "Created On",
                          text2: formatTo_ddMMyyyy(
                            controller.retailerModel.value?.createdAt,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: AppSize.width(value: 12),
                    children: [
                      Expanded(
                        child: ItemCard(
                          iconPath: AssetsPath.icVerification,
                          text1: "Verification",
                          text2:
                              "Verification: ${controller.retailerModel.value?.status}",
                        ),
                      ),
                      Expanded(
                        child: ItemCard(
                          iconPath: AssetsPath.icRole,
                          text1: "Role",
                          text2:
                              controller.retailerModel.value?.role ??
                              "RETAILER",
                        ),
                      ),
                    ],
                  ),
                  Gap(height: AppSize.width(value: 12)),

                  AppText(
                    data: "Order History",
                    fontSize: AppSize.width(value: 18),
                    fontWeight: FontWeight.w700,
                    color: AppColor.black,
                  ),
                  SalesRepresentativeHistory(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ItemCard extends StatelessWidget {
  final String? iconPath;
  final String? text1;
  final String? text2;
  const ItemCard({super.key, this.iconPath, this.text1, this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.black),
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppSize.width(value: 16),
        horizontal: AppSize.width(value: 12),
      ),
      child: Row(
        children: [
          AppImage(
            iconColor: AppColor.black,
            width: AppSize.width(value: 28),
            path: iconPath ?? AssetsPath.box,
          ),
          Gap(width: AppSize.width(value: 8)),
          Column(
            spacing: AppSize.size.height * 0.006,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: text1 ?? "Address",
                fontSize: AppSize.width(value: 12),
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
              AppText(
                data: text2 ?? "Ampal,Muradnagor",
                maxLines: 1,
                fontSize: AppSize.width(value: 12),
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
