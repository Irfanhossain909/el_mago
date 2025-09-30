import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/const/role.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/auth/sign_up_screen/controller/signup_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_input/add_descreption_text_field.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_input/labeled_radio.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              GetBuilder<SignUpController>(
                init: SignUpController(),
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.all(AppSize.width(value: 12)),

                    child: Form(
                      key: controller.formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        // spacing: AppSize.size.height * 0.005,
                        children: [
                          Center(
                            child: AppImage(
                              path: AssetsPath.appLogo,
                              width: AppSize.size.width * 0.45,
                              // height: AppSize.size.width * 0.22,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Gap(height: AppSize.size.height * 0.02),
                          AppText(
                            data: "Create Your Account",
                            fontSize: AppSize.width(value: 18),
                            fontWeight: FontWeight.w600,
                            color: AppColor.black,
                          ),
                          Gap(height: AppSize.size.height * 0.01),
                          AppText(
                            data: "Let's dive in into your occount",
                            fontSize: AppSize.width(value: 14),
                            fontWeight: FontWeight.w400,
                            color: AppColor.black,
                          ),
                          Gap(height: AppSize.size.height * 0.02),
                          AppInputWidgetTwo(
                             validator: controller.validateFirstName,
                            controller: controller.fullNameController,
                            borderRadius: AppSize.width(value: 8),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(value: 20),
                            ),
                            hintText: "Full Name",
                          ),
                          AppInputWidgetTwo(
                            validator: controller.validateEmail,

                            controller: controller.emailController,
                            isEmail: true,
                            borderRadius: AppSize.width(value: 8),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(value: 20),
                            ),
                            hintText: "example@gmail.com",
                          ),
                          Obx(() {
                            return Stack(
                              children: [
                                AppDescriptionTextField(
                                  controller: controller.addressController,
                                  hintText: "Enter Your Full Address",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppSize.width(value: 12),
                                    ),
                                    borderSide: BorderSide(color: AppColor.black),
                                  ),
                                ),
                                controller.isLoading.value
                                    ? Center(child: AppLoading())
                                    : SizedBox(),
                              ],
                            );
                          }),
                      
                          AppInputWidgetTwo(
                            validator: controller.validatePassword,
                            controller: controller.passwordController,
                            borderRadius: AppSize.width(value: 8),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(value: 20),
                            ),
                            isPassWord: true,
                            hintText: "Password",
                          ),
                          AppInputWidgetTwo(
                            validator: controller.validateRePassword,
                            controller: controller.confirmpasswordController,
                            borderRadius: AppSize.width(value: 8),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(value: 20),
                            ),
                            isPassWord: true,
                            hintText: "Confirm Password",
                          ),
                      
                          Gap(height: AppSize.width(value: 12)),
                          Obx(() {
                            final selected = controller.userRole.value;
                            return Row(
                              spacing: AppSize.width(value: 16),
                              children: [
                                LabeledRadio<Role>(
                                  label: "Sales Rep.",
                                  value: Role.SALES,
                                  groupValue: selected,
                                  onChanged: controller.setUserRole,
                                ),
                                LabeledRadio<Role>(
                                  label: "Retailer",
                                  value: Role.RETAILER,
                                  groupValue: selected,
                                  onChanged: controller.setUserRole,
                                ),
                              ],
                            );
                          }),
                          Gap(height: AppSize.width(value: 12)),
                          GestureDetector(
                            onTap: () {
                              controller.signUp();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: AppSize.width(value: double.infinity),
                              height: AppSize.size.height * 0.06,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppText(
                                    data: "Sign Up",
                                    fontSize: AppSize.width(value: 18),
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_right_alt_outlined,
                                      size: AppSize.width(value: 28),
                                      color: AppColor.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(height: AppSize.size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText(
                                data: "already have an account?",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              Gap(width: AppSize.width(value: 4)),
                              InkWell(
                                onTap: () {
                                  Get.offNamed(AppRoutes.instance.signinScreen);
                                },
                                child: AppText(
                                  data: "Sign In",
                                  fontSize: AppSize.width(value: 18),
                                  color: AppColor.blue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
