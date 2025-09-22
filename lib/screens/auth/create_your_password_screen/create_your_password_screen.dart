import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(18),
          child: Icon(Icons.arrow_back_ios, color: AppColor.black, size: 18),
        ),
      ),
      body: Column(
        spacing: AppSize.size.height * 0.02,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            data: "Set Your New Password",
            fontSize: AppSize.width(value: 22),
            fontWeight: FontWeight.w700,
            color: AppColor.black,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 30)),
            child: AppText(
              data:
                  "Create a new password for your account. Make sure it’s strong and secure.",
              textAlign: TextAlign.center,
              fontSize: AppSize.width(value: 16),
              fontWeight: FontWeight.w400,
              color: AppColor.black,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(AppSize.width(value: 12)),

            child: Column(
              spacing: AppSize.size.height * 0.01,
              children: [
                AppInputWidgetTwo(
                  borderRadius: AppSize.width(value: 8),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 20),
                  ),
                  isPassWord: true,
                  hintText: "Password",
                ),
                AppInputWidgetTwo(
                  borderRadius: AppSize.width(value: 8),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSize.width(value: 20),
                  ),
                  isPassWord: true,
                  hintText: "Confirm Password",
                ),
                Gap(height: AppSize.width(value: 12)),

                AppButton(
                  onTap: () {
                    // Get.toNamed(AppRoutes.instance.verifyOtpScreen);
                  },
                  title: "Save New Password",
                  titleSize: AppSize.width(value: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
