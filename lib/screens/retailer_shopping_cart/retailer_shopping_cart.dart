import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_dropdown/custom_sdropdown.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class RetailerShoppingCart extends StatelessWidget {
  const RetailerShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Shopping Cart'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 16)),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ShoppingCard();
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(AppSize.width(value: 16)),
          // height: AppSize.size.height * 0.45,
          color: AppColor.blue,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                data: "Shopping Cart",
                fontSize: AppSize.width(value: 18),
                fontWeight: FontWeight.w700,
                color: AppColor.white,
              ),
              Gap(height: AppSize.size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    data: "Total Box",
                    fontSize: AppSize.width(value: 12),
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                  AppText(
                    data: "26",
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    data: "Original Amount:",
                    fontSize: AppSize.width(value: 12),
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                  AppText(
                    data: r"$2886.00",
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                ],
              ),
              Gap(height: AppSize.size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: AppColor.blue500,
                ),
                padding: EdgeInsets.all(AppSize.width(value: 12)),
                child: Row(
                  spacing: AppSize.width(value: 4),
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppImage(
                      path: AssetsPath.gift,
                      width: AppSize.width(value: 12),
                    ),
                    AppText(
                      data: "No rewards available at the moment",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ),
              Gap(height: AppSize.size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  color: AppColor.blue500,
                ),
                padding: EdgeInsets.all(AppSize.width(value: 12)),
                child: Row(
                  spacing: AppSize.width(value: 4),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      data: "Final Amount:",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                      color: AppColor.white,
                    ),
                    AppText(
                      data: "\$2886.00",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ],
                ),
              ),
              Gap(height: AppSize.size.height * 0.01),
              AppText(
                data:
                    "Shipping and/or processing fees to be added on the final invoice",
                fontSize: AppSize.width(value: 12),
                fontWeight: FontWeight.w400,
                color: AppColor.white,
              ),
              Gap(height: AppSize.size.height * 0.01),
              AppText(
                data: "Terms",
                fontSize: AppSize.width(value: 18),
                fontWeight: FontWeight.w700,
                color: AppColor.white,
              ),
              Gap(height: AppSize.size.height * 0.01),
              CustomDropdown(
                items: ["Irfan", "Billah", "Sabbir"],
                selectedValue: "Irfan",
                hint: "Deu to Recipt",
                onChanged: (p0) {},
              ),
              Gap(height: AppSize.size.height * 0.025),
              AppButton(title: "Place Order", filColor: Color(0xff03DAC5)),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingCard extends StatelessWidget {
  const ShoppingCard({super.key});

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
            buildRowItem("Product Name", "Subtitle"),
            buildRowItem("Product Size", "Subtitle"),
            buildRowItem("Box Count", "Subtitle"),
            buildRowItem("Product Price", "Subtitle"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: "Box Count",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Minus button
                      InkWell(
                        onTap: () {
                          // Decrement logic here
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 12),
                            vertical: AppSize.width(value: 8),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSize.width(value: 8)),
                              bottomLeft: Radius.circular(
                                AppSize.width(value: 8),
                              ),
                            ),
                            color: AppColor.white,
                          ),

                          child: Icon(
                            Icons.remove,
                            size: AppSize.width(value: 18),
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      // Quantity display
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 12),
                          vertical: AppSize.width(value: 6),
                        ),
                        decoration: BoxDecoration(color: AppColor.white),
                        child: AppText(
                          data: "1",
                          fontSize: 16,
                          color: AppColor.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Plus button
                      InkWell(
                        onTap: () {
                          // Increment logic here
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(
                                AppSize.width(value: 8),
                              ),
                              bottomRight: Radius.circular(
                                AppSize.width(value: 8),
                              ),
                            ),
                            color: AppColor.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 12),
                            vertical: AppSize.width(value: 8),
                          ),

                          child: Icon(
                            Icons.add,
                            size: AppSize.width(value: 18),
                            color: AppColor.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            buildRowItem("Total Amount", "Subtitle"),
            // Calling the private method here
          ],
        ),
      ),
    );
  }

  Widget buildRowItem(String? title, String? subtitle) {
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
          data: subtitle ?? "No Text",
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w400,
          color: AppColor.black,
        ),
      ],
    );
  }
}
