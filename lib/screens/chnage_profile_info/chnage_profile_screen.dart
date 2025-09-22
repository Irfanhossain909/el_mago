import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_image/app_image_circular.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class ChnageProfileScreen extends StatelessWidget {
  const ChnageProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(title: "Change Profile Information"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(height: AppSize.size.height * 0.005),
            Stack(
              children: [
                AppImageCircular(
                  fit: BoxFit.cover,
                  url:
                      "https://cdn.pixabay.com/photo/2016/12/07/21/01/cartoon-1890438_640.jpg",
                  width: AppSize.width(value: 148),
                  height: AppSize.width(value: 148),
                ),
                Positioned(
                  bottom: 2,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.black),
                      borderRadius: BorderRadius.circular(
                        AppSize.width(value: 24),
                      ),
                      color: AppColor.white,
                    ),
                    padding: EdgeInsets.all(AppSize.width(value: 8)),
                    child: AppImage(
                      path: AssetsPath.camera,
                      width: AppSize.width(value: 18),
                      height: AppSize.width(value: 18),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
                  color: AppColor.white,
                  border: Border.all(
                    color: AppColor.black.withValues(alpha: 0.1),
                  ),
                ),
                padding: EdgeInsets.all(AppSize.width(value: 20)),
                child: Column(
                  spacing: AppSize.size.height * 0.01,
                  children: [
                    AppInputWidgetTwo(
                      isOptional: true,
                      title: "Full Name",
                      hintText: "Enter Name",
                    ),
                    AppInputWidgetTwo(
                      isOptional: true,
                      title: "Phone Number",
                      hintText: "Enter Number",
                    ),
                    AppInputWidgetTwo(
                      isOptional: true,
                      title: "Email",
                      hintText: "Enter Email",
                    ),
                    AppInputWidgetTwo(
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
            title: "Save",
            titleSize: AppSize.width(value: 18),
            borderRadius: BorderRadius.circular(AppSize.width(value: 24)),
          ),
        ),
      ),
    );
  }
}
