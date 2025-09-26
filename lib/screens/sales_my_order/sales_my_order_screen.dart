import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_circle_card/circle_icon_with_bg.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SalesMyOrderScreen extends StatelessWidget {
  const SalesMyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'My Order',
        action: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: CircleIconWithBg(onTap: () {}, path: AssetsPath.filter),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Fixed input field at the top
            AppInputWidgetTwo(
              borderColor: AppColor.button,
              contentPadding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 12.0,
              ),
              hintText: "Search by invoice ID o r Product Name",
            ),

            // Make the ListView scrollable independently
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return SalesViewOrderCard(
                    onTap: () {
                      Get.toNamed(AppRoutes.instance.salesOrderDetailsScreen);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesViewOrderCard extends StatelessWidget {
  final VoidCallback? onTap;
  const SalesViewOrderCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSize.size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.width(value: 16)),
          border: Border.all(color: AppColor.black.withValues(alpha: 0.1)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 16),
          vertical: AppSize.width(value: 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSize.size.height * 0.01,
          children: [
            buildOrderDetails(title: "Invoice#", value: "Jaguar"),
            buildOrderDetails(
              title: "Retailer Name",
              value: "Ampal,Muradnagor",
            ),
            buildOrderDetails(title: "Address", value: "Ampal,Muradnagor"),
            buildOrderDetails(title: "Order date", value: "19/09/2025"),
            buildOrderDetails(title: "Order Quantity", value: "2"),
            buildOrderDetails(title: "Amount", value: "\$132"),
            buildOrderDetails(title: "Status", value: "Delivered"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),

                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
            ), // Calling the private method here
          ],
        ),
      ),
    );
  }

  Widget buildOrderDetails({String? title, String? value}) {
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
