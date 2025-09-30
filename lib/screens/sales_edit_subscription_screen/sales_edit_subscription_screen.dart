import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/models/sub_model/sub_model.dart';
import 'package:el_mago/screens/sales_edit_subscription_screen/controller/sales_subscription_edit_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_dropdown/custom_dropdown.dart';
import 'package:el_mago/widgets/app_dropdown/custom_dropdown_with_map.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesEditSubscriptionScreen extends StatelessWidget {
  const SalesEditSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesSubscriptionEditController>(
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: "Edit Subscription"),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(() {
              return Column(
                spacing: AppSize.size.height * 0.01,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: AppText(
                      data: "Subscription",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                  CustomDropdownWithMap(
                    items: getMap(controller.subTypeList.value),
                    selectedValue: 0,
                    hint: 'subscription',
                    onChanged: (index) {
                      controller.onSelectionChange(index);
                    },
                  ),
                  // CustomDropdown(
                  //   items: ["Basic", "Advence"],
                  //   hint: "Select",
                  //   selectedValue: "Basic",
                  //   onChanged: (value) {},
                  // ),
                  AppInputWidgetTwo(
                    controller: controller.tireController,
                    isOptional: true,
                    title: "Tier",
                    hintText: "Tier",
                  ),
                  // AppInputWidgetTwo(
                  //   isOptional: true,
                  //   title: "No Credit Card Fee",
                  //   hintText: "No Credit Card Fee",
                  // ),
                  // AppInputWidgetTwo(
                  //   isOptional: true,
                  //   title: "Exclusive Products",
                  //   hintText: "Exclusive Products",
                  // ),
                  // AppInputWidgetTwo(
                  //   isOptional: true,
                  //   title: "Limited Releases",
                  //   hintText: "Limited Releases",
                  // ),
                ],
              );
            }),
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
                  Expanded(
                    child: AppButton(
                      onTap: () => controller.addRetailer(),
                      title: "Add Retailer",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map<int, String> getMap(List<SubModelData> models) {
    final list = models.map((e) {
      print(e.subscription);
      int index = models.indexOf(e);
      return MapEntry(index, e.subscription ?? '');
    });

    return Map.fromEntries(list);
  }
}
