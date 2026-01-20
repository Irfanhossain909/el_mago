import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/chnage_profile_info/controller/chnage_profile_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_image/app_image_circular.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChnageProfileScreen extends StatelessWidget {
  const ChnageProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChnageProfileController>(
      init: ChnageProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(title: "Change Profile Information"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Gap(height: AppSize.size.height * 0.005),
                Obx(() {
                  return Stack(
                    children: [
                      Container(
                        width: AppSize.size.width * 0.33,
                        height: AppSize.size.height * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.white, width: 2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            child: controller.cameraImage.value.isNotEmpty
                                ? AppImageCircular(
                                    filePath: controller.cameraImage.value,
                                  )
                                : AppImageCircular(
                                    url:
                                        "${AppApiEndPoint.domain}${controller.profileController.profileData.value?.image}",
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,

                        child: InkWell(
                          onTap: () {
                            controller.getImage(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: AppColor.black,
                                width: 2,
                              ),
                              color: AppColor.white,
                            ),
                            child: AppImage(
                              path: AssetsPath.camera,
                              iconColor: AppColor.black,
                              width: AppSize.width(value: 16),
                              height: AppSize.width(value: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(AppSize.width(value: 16)),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSize.width(value: 12),
                          ),
                          color: AppColor.white,
                          border: Border.all(
                            color: AppColor.black.withValues(alpha: 0.1),
                          ),
                        ),
                        padding: EdgeInsets.all(AppSize.width(value: 20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppSize.size.height * 0.01,
                          children: [
                            AppInputWidgetTwo(
                              isOptional: true,
                              controller: controller.nameController,
                              title: "Full Name",
                              hintText: "Enter Name",
                            ),
                            AppInputWidgetTwo(
                              isOptional: true,
                              controller: controller.phoneController,
                              title: "Phone Number",
                              hintText: "Enter Number",
                            ),
                            AppText(
                              data: "Email",
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: AppColor.black,
                            ),

                            GestureDetector(
                              onTap: () {
                                Get.snackbar(
                                  "Warning!!!",
                                  "Email can't be changed",
                                );
                              },
                              child: Container(
                                width: AppSize.width(value: double.infinity),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColor.black.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.all(20),

                                child: AppText(
                                  data:
                                      controller
                                          .profileController
                                          .profileData
                                          .value
                                          ?.email ??
                                      "",
                                  fontSize: AppSize.width(value: 16),
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black.withValues(alpha: 0.2),
                                ),
                              ),
                            ),

                            AppInputWidgetTwo(
                              maxLines: 4,
                              controller: controller.addressController,
                              textColor: AppColor.black,
                              borderColor: AppColor.black,
                              hintColor: AppColor.black.withValues(alpha: 0.4),
                              isOptional: true,
                              title: "Address",
                              hintText: "Enter Address",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: AppLoading(),
                        );
                      }
                      return SizedBox.shrink();
                    }),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(value: 16),
                vertical: AppSize.width(value: 20),
              ),
              child: AppButton(
                onTap: () {
                  controller.updateProfile();
                },
                title: "Save",
                titleSize: AppSize.width(value: 18),
                borderRadius: BorderRadius.circular(AppSize.width(value: 24)),
              ),
            ),
          ),
        );
      },
    );
  }
}
