import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:el_mago/screens/retailer_my_subscription_screen/controller/retailer_my_subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerMySubscriptionScreen extends StatelessWidget {
  const RetailerMySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RetailerMySubscriptionController>(
      init: RetailerMySubscriptionController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            autoShowLeading: false,
            title: 'My Subscription',
          ),
          body: Padding(
            padding: EdgeInsets.all(AppSize.width(value: 16)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    spacing: AppSize.width(value: 24),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue.withValues(alpha: 0.3),
                        ),
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: Colors.blue,
                              size: 16,
                            ),
                            Gap(width: AppSize.width(value: 8)),
                            AppText(
                              data: "Next window opens in: 12 days",
                              fontSize: AppSize.width(value: 12),
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: AppButton(
                          height: AppSize.width(value: 38),
                          width: AppSize.size.width * 0.4,
                          title: "Edit Selected Boxes",
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: AppSize.size.height * 0.7,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: AppSize.size.height * 0.002,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: AppSize.size.width * 0.9,
                          child: SubcriptionCard(),
                        );
                      },
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

class SubcriptionCard extends StatefulWidget {
  const SubcriptionCard({super.key});

  @override
  State<SubcriptionCard> createState() => _SubcriptionCardState();
}

class _SubcriptionCardState extends State<SubcriptionCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .1),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .1),
                        offset: Offset(0, -2),
                        blurRadius: 8,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(
                      AppSize.width(value: 12),
                    ),
                    color: AppColor.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSize.size.height * 0.04,
                          horizontal: AppSize.size.width * 0.1,
                        ),
                        child: Column(
                          spacing: AppSize.size.height * 0.015,
                          children: [
                            AppImage(
                              width: AppSize.width(value: 40),
                              height: AppSize.width(value: 40),
                              path: AssetsPath.subscriptionIcon,
                            ),
                            AppText(
                              data: "Platinum",
                              fontSize: AppSize.width(value: 40),
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            Gap(height: AppSize.size.height * 0.02),
                            SubWidGetRow(text: "Advanced custom fieldsEdit"),
                            SubWidGetRow(text: "Audit log and data history"),
                            SubWidGetRow(text: "Unlimited individual users"),
                            SubWidGetRow(text: "Unlimited individual data"),
                            SubWidGetRow(text: "Personalised+priotity service"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 16),
                          vertical: AppSize.width(value: 16),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: AppSize.width(value: 24),
                              width: AppSize.width(value: 24),
                              child: Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                                activeColor: AppColor.blue,
                                checkColor: Colors.white,
                                side: BorderSide(
                                  color: AppColor.black,
                                  width: 2,
                                ),
                              ),
                            ),
                            Gap(width: AppSize.width(value: 12)),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to terms and conditions screen
                                },
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: AppSize.width(value: 14),
                                      color: Colors.black87,
                                    ),
                                    children: [
                                      TextSpan(text: "I Agree to the "),
                                      TextSpan(
                                        text: "terms & conditions",
                                        style: TextStyle(
                                          color: AppColor.blue,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 28),
                          vertical: AppSize.width(value: 24),
                        ),
                        child: AppButton(
                          borderRadius: BorderRadius.circular(12),
                          title: "Choose Plan",
                          filColor: isChecked
                              ? AppColor.blue
                              : AppColor.blue.withValues(alpha: 0.3),
                          onTap: () {
                            if (isChecked) {
                              Get.snackbar(
                                "Plan Selected",
                                "Platinum plan has been selected!",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar(
                                "Terms Required",
                                "Please agree to terms & conditions first",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: 10,
            right: 0,
            child: AppImage(
              width: AppSize.width(value: 88),
              path: AssetsPath.activeCard,
            ),
          ),
        ],
      ),
    );
  }
}

class SubWidGetRow extends StatelessWidget {
  final String? text;
  const SubWidGetRow({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSize.width(value: 24),
      children: [
        Icon(
          Icons.done_rounded,
          color: AppColor.blue,
          size: AppSize.width(value: 20),
        ),
        Expanded(
          child: AppText(
            data: text ?? "No Text",
            fontSize: AppSize.width(value: 16),
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
