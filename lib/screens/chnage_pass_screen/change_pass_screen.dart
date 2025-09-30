import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/chnage_pass_screen/controller/chnage_password_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChnagePasswordController>(
      init: ChnagePasswordController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(value: 16),
                vertical: AppSize.width(value: 20),
              ),
              child: AppButton(
                onTap: () {
                  controller.changePassword();
                },
                title: "Save",
                titleSize: AppSize.width(value: 18),
                borderRadius: BorderRadius.circular(AppSize.width(value: 24)),
              ),
            ),
          ),
          appBar: CustomAppbar(title: "Change Password"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AppImage(
                  width: AppSize.size.width * 0.6,
                  path: AssetsPath.changePass,
                ),

                Padding(
                  padding: EdgeInsets.all(AppSize.width(value: 16)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.width(value: 12),
                      ),
                      color: AppColor.white,
                    ),
                    padding: EdgeInsets.all(AppSize.width(value: 20)),
                    child: Stack(
                      children: [
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: controller.formKey,
                          child: Column(
                            spacing: AppSize.size.height * 0.01,
                            children: [
                              AppInputWidgetTwo(
                                validator: controller.validateOldPassword,
                                isPassWord: true,
                                controller: controller.oldPasswordController,
                                isOptional: true,
                                title: "Old Password",
                                hintText: "Enter Old Password",
                              ),
                              AppInputWidgetTwo(
                                validator: controller.validateNewPassword,
                                isPassWord: true,
                                controller: controller.newPasswordController,
                                isOptional: true,
                                title: "New Password",
                                hintText: "Enter New Password",
                              ),
                              AppInputWidgetTwo(
                                validator: (value) {
                                  return controller.validateConfirmPassword(
                                    value,
                                    controller.newPasswordController.text,
                                  );
                                },
                                isPassWord: true,
                                controller: controller.confirmPasswordController,
                                isOptional: true,
                                title: "Confirm Password",
                                hintText: "Enter Confirm Password",
                              ),
                            ],
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
