import 'package:flutter/material.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_button/app_button.dart';
import 'package:tinnierenee12/widget/app_input/add_descreption_text_field.dart';
import 'package:tinnierenee12/widget/app_input/app_input_widget_two.dart';
import 'package:tinnierenee12/widget/app_text/app_text.dart';
import 'package:tinnierenee12/widget/appbar/custom_appbar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.width(value: 16),
            vertical: AppSize.width(value: 20),
          ),
          child: AppButton(
            title: "Submit",
            titleSize: AppSize.width(value: 18),
            borderRadius: BorderRadius.circular(AppSize.width(value: 24)),
          ),
        ),
      ),
      appBar: CustomAppbar(title: "Contact Us"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.width(value: 12)),
                  color: AppColor.white,
                ),
                padding: EdgeInsets.all(AppSize.width(value: 20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSize.size.height * 0.01,
                  children: [
                    AppText(
                      data: "Contact Us",
                      fontSize: AppSize.width(value: 18),
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    AppInputWidgetTwo(
                      textColor: AppColor.black,
                      borderColor: AppColor.black,
                      hintColor: AppColor.black.withValues(alpha: 0.4),
                      isOptional: true,
                      title: "Full Name",
                      hintText: "Enter Name",
                    ),
                    AppInputWidgetTwo(
                      textColor: AppColor.black,
                      borderColor: AppColor.black,
                      hintColor: AppColor.black.withValues(alpha: 0.4),
                      isOptional: true,
                      title: "Email",
                      hintText: "Enter Email",
                    ),
                    AppInputWidgetTwo(
                      textColor: AppColor.black,
                      borderColor: AppColor.black,
                      hintColor: AppColor.black.withValues(alpha: 0.4),
                      isOptional: true,
                      title: "Subject",
                      hintText: "Enter Subject",
                    ),
                    AppDescriptionTextField(
                      textColor: AppColor.black,
                      titleColor: AppColor.black,
                      hintColor: AppColor.black.withValues(alpha: 0.4),
                      title: 'Feedback',
                      fillColor: AppColor.white,
                      hintText: "Write Your Feedback Here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppSize.width(value: 12),
                        ),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
