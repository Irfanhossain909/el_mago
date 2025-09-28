import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class RetailerComplateSubscriptionScreen extends StatelessWidget {
  const RetailerComplateSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Complete Subscription"),
      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSize.size.height * 0.01,
            children: [
              AppText(
                fontSize: AppSize.width(value: 18),
                fontWeight: FontWeight.w400,
                color: AppColor.black,
                data:
                    "Payment for Gold Tier : 4 boxes per month + 1 free box per quarter",
              ),

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
                    AppText(
                      data: "Plan Details",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      children: [
                        AppText(
                          data: "Tier:",
                          fontSize: AppSize.width(value: 12),
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          data: " GOLD",
                          fontSize: AppSize.width(value: 12),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AppText(
                          data: "Features:",
                          fontSize: AppSize.width(value: 12),
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          data:
                              " Gold Tier : 4 boxes per month + 1 free box per quarter",
                          fontSize: AppSize.width(value: 12),
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    AppText(
                      data: "-  Free Shipping – Free ship ",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                    ),

                    AppText(
                      data: "-  No Credit Card Fee – Waived 3% credit card fee",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                    ),
                    AppText(
                      data: "-  Exclusive Products – Yes",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                    ),
                    AppText(
                      data: "-  Flash Discounts – Special exclusive offers",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                    ),
                    AppText(
                      data: "-  Limited Releases – Yes",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              AppInputWidgetTwo(
                isOptional: true,
                title: "Name On Card",
                hintText: "Enter name on card",
              ),

              AppInputWidgetTwo(
                keyboardType: TextInputType.number,
                isOptional: true,
                title: "Card number",
                hintText: "|",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppImage(
                    width: AppSize.width(value: 24),
                    path: AssetsPath.card1,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: AppInputWidgetTwo(
                      keyboardType: TextInputType.number,
                      isOptional: true,
                      title: "Expiry",
                      hintText: "mm/yy",
                    ),
                  ),
                  Gap(width: AppSize.width(value: 8)),
                  Expanded(
                    child: AppInputWidgetTwo(
                      keyboardType: TextInputType.number,
                      isOptional: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AppImage(
                          width: AppSize.width(value: 24),
                          path: AssetsPath.cvv,
                        ),
                      ),
                      title: "CVC",
                      hintText: "***",
                    ),
                  ),
                ],
              ),
              AppInputWidgetTwo(
                isOptional: true,
                title: "Zip Code",
                hintText: "|",
              ),
              AppButton(
                height: AppSize.size.height * 0.055,
                title: "Confirm Payment Info",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
