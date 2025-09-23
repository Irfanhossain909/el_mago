import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class RetailerDashBoard extends StatelessWidget {
  const RetailerDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Dashboard Overview",
        action: [
          CircleIconWithBg(path: AssetsPath.cart),
          Gap(width: AppSize.width(value: 8)),
          CircleIconWithBg(path: AssetsPath.notification),
          Gap(width: AppSize.width(value: 8)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                spacing: AppSize.width(value: 12),
                children: [
                  Expanded(
                    child: RetailerDataCard(
                      path: AssetsPath.dollerColor,
                      title: r"$0.00",
                      subTitle: "Total Earned",
                    ),
                  ),
                  Expanded(
                    child: RetailerDataCard(
                      path: AssetsPath.cartColor,
                      title: r"$0.00",
                      subTitle: "Total Orders Placed",
                    ),
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: AppSize.size.height * 0.02),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return RetailerDashBoardCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RetailerDashBoardCard extends StatelessWidget {
  const RetailerDashBoardCard({super.key});

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
            _buildProductNameRow(
              "Product Name",
              "Jaguar",
            ), // Calling the private method here
            _buildProductNameRow(
              "Product Size",
              "6x50 Toro Box-Press",
            ), // Calling the private method here
            _buildProductNameRow(
              "Box Count",
              "12",
            ), // Calling the private method here
            _buildProductNameRow(
              "Available Stock",
              "Yes",
            ), // Calling the private method here
            _buildProductNameRow("Product Price", r"$111"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: "Add to Cart",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 6),
                    ),
                    color: AppColor.blue,
                  ),
                  child: AppText(
                    data: "Add",
                    fontSize: AppSize.width(value: 16),
                    color: AppColor.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ), // Calling the private method here
          ],
        ),
      ),
    );
  }

  // Private method to build the Row widget
  Widget _buildProductNameRow(String? name, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: name ?? "No Text",
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

class CircleIconWithBg extends StatelessWidget {
  final String? path;
  const CircleIconWithBg({super.key, this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.width(value: 8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.width(value: 16)),
        color: AppColor.blue,
      ),
      child: AppImage(
        path: path ?? AssetsPath.cart,
        width: AppSize.width(value: 16),
      ),
    );
  }
}
