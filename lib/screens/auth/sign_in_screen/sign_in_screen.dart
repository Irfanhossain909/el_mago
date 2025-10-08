import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/auth/sign_in_screen/controller/signin_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_loading/app_loading.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SigninController>(
          init: SigninController(),
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.all(AppSize.width(value: 12)),

              child: Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: AppSize.size.height * 0.01,
                          children: [
                            Center(
                              child: AppImage(
                                path: AssetsPath.appLogo,
                                width: AppSize.size.width * 0.65,
                                // height: AppSize.size.width * 0.22,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Gap(height: AppSize.size.height * 0.009),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.size.width * 0.2,
                              ),
                              child: AppText(
                                height: 1.4,
                                textAlign: TextAlign.center,
                                data:
                                    "Please enter your email and password to continue",
                                fontSize: AppSize.width(value: 14),
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                              ),
                            ),
                            AppInputWidgetTwo(
                              keyboardType: TextInputType.emailAddress,
                              validator: controller.validateEmail,
                              controller: controller.emailController,
                              isEmail: true,
                              borderRadius: AppSize.width(value: 8),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSize.width(value: 20),
                              ),
                              hintText: "example@gmail.com",
                            ),

                            AppInputWidgetTwo(
                              keyboardType: TextInputType.visiblePassword,
                              validator: controller.validatePassword,
                              controller: controller.passwordController,
                              borderRadius: AppSize.width(value: 8),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: AppSize.width(value: 20),
                              ),
                              isPassWord: true,
                              hintText: "Password",
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.instance.forgetPasswordScreen,
                                  );
                                },
                                child: AppText(
                                  data: "Forgot Password",
                                  fontSize: AppSize.width(value: 16),
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.blue,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                AppPrint.appLog("Tap to Signin");
                                controller.signin();
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
                                      data: "Sign In",
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
                            Gap(height: AppSize.size.height * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  data: "Don’t Have an Account?",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                Gap(width: AppSize.width(value: 4)),
                                InkWell(
                                  onTap: () {
                                    Get.offNamed(
                                      AppRoutes.instance.signupScreen,
                                    );
                                  },
                                  child: AppText(
                                    data: "Sign Up",
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
                    ),
                  ),
                  Obx(() {
                    return Center(
                      child: controller.loading.value
                          ? AppLoading()
                          : SizedBox(),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
