import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_input/add_descreption_text_field.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class SalesEditNewRetailersScreen extends StatelessWidget {
  const SalesEditNewRetailersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Edit Retailer"),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                data: "Retailer Information",
                fontSize: AppSize.width(value: 14),
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              AppInputWidgetTwo(
                isOptional: true,
                title: "Retailer Name",
                hintText: "Retailer Name",
              ),
              AppInputWidgetTwo(
                isOptional: true,
                title: "Email",
                hintText: "Email",
              ),
              AppInputWidgetTwo(
                isOptional: true,
                title: "Phone",
                hintText: "Phone",
              ),
              AppDescriptionTextField(
                title: "Shipping Address",
                hintText: "Shipping Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColor.black.withValues(alpha: 0.8),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: AppText(
                  data: "Payment Information",
                  fontSize: AppSize.width(value: 14),
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
              ),
              AppInputWidgetTwo(hintText: "Card Name"),
              AppInputWidgetTwo(hintText: "Card Number"),
              Row(
                spacing: AppSize.width(value: 12),
                children: [
                  Expanded(child: AppInputWidgetTwo(hintText: "mm/yy")),
                  Expanded(child: AppInputWidgetTwo(hintText: "CVC")),
                ],
              ),
              AppInputWidgetTwo(hintText: "Zip code"),
            ],
          ),
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
              Expanded(child: AppButton(title: "Update Retailer")),
            ],
          ),
        ),
      ),
    );
  }
}
