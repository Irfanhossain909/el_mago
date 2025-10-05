import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/sales_add_retailers_screen/controller/sales_add_retailer_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_input/add_descreption_text_field.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SalesAddRetailersScreen extends StatelessWidget {
  const SalesAddRetailersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesAddRetailerController>(
      init: SalesAddRetailerController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: "Add Retailer"),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        data: "Retailer Information",
                        fontSize: AppSize.width(value: 14),
                        fontWeight: FontWeight.w600,
                        color: AppColor.black,
                      ),
                      AppInputWidgetTwo(
                        controller: controller.retailerNameController,
                        isOptional: true,
                        title: "Retailer Name",
                        hintText: "Retailer Name",
                      ),
                      AppInputWidgetTwo(
                        controller: controller.retailerEmailController,
                        isOptional: true,
                        isEmail: true,
                        title: "Email",
                        hintText: "Email",
                      ),
                      AppInputWidgetTwo(
                        keyboardType: TextInputType.phone,
                        controller: controller.retailerPhoneController,
                        isOptional: true,
                        title: "Phone",
                        hintText: "Phone",
                      ),
                      AppDescriptionTextField(
                        controller: controller.retailerAddressController,

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
                      AppInputWidgetTwo(
                        controller: controller.cardNameController,
                        hintText: "Card Name",
                      ),
                      AppInputWidgetTwo(
                        keyboardType: TextInputType.number,
                        controller: controller.cardNumberController,
                        hintText: "Card Number",
                        isCard: true,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: AppInputWidgetTwo(
                              keyboardType: TextInputType.phone,
                              hintText: "MM/YY",
                              controller: controller.expiryController,
                              isExpiryField: true, // auto slash format
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppInputWidgetTwo(
                              keyboardType: TextInputType.phone,
                              hintText: "123",
                              controller: controller.cvcController,
                              cvvLength: 4,
                              isCvvField: true, // 3-digit only
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   spacing: AppSize.width(value: 12),
                      //   children: [
                      //     Expanded(
                      //       child: AppInputWidgetTwo(
                      //         keyboardType: TextInputType.phone,
                      //         controller: controller.expiryController,
                      //         hintText: "mm/yy",
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: AppInputWidgetTwo(
                      //         keyboardType: TextInputType.phone,
                      //         controller: controller.cvcController,
                      //         hintText: "CVC",
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      AppInputWidgetTwo(
                        keyboardType: TextInputType.phone,
                        controller: controller.zipController,
                        hintText: "Zip code",
                      ),
                    ],
                  ),
                  Obx(() {
                    return controller.isLoading.value
                        ? Positioned(
                            right: 0,
                            left: 0,
                            top: AppSize.size.height * 0.4,
                            child: Center(child: AppLoading()),
                          )
                        : SizedBox();
                  }),
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
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
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
                  ),
                  Expanded(
                    child: AppButton(
                      onTap: () {
                        controller.createRetailer();
                      },
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
}
