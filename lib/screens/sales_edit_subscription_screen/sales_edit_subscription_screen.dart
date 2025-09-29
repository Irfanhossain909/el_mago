import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_dropdown/custom_dropdown.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class SalesEditSubscriptionScreen extends StatelessWidget {
  const SalesEditSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Edit Subscription"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          spacing: AppSize.size.height * 0.01,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: AppText(
                data: "Retailer Information",
                fontSize: AppSize.width(value: 14),
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
            ),
            CustomDropdown(
              items: ["Basic", "Advence"],
              hint: "Select",
              selectedValue: "Basic",
              onChanged: (value) {},
            ),
            AppInputWidgetTwo(
              isOptional: true,
              title: "Tier",
              hintText: "Tier",
            ),
            AppInputWidgetTwo(
              isOptional: true,
              title: "No Credit Card Fee",
              hintText: "No Credit Card Fee",
            ),
            AppInputWidgetTwo(
              isOptional: true,
              title: "Exclusive Products",
              hintText: "Exclusive Products",
            ),
            AppInputWidgetTwo(
              isOptional: true,
              title: "Limited Releases",
              hintText: "Limited Releases",
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            spacing: AppSize.width(value: 12),
            children: [
              Expanded(
                child: Container(
                  height: AppSize.size.height * 0.06,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColor.black),
                  ),
                  child: Center(child: AppText(data: "Cancel")),
                ),
              ),
              Expanded(child: AppButton(title: "Add Retailer")),
            ],
          ),
        ),
      ),
    );
  }
}
