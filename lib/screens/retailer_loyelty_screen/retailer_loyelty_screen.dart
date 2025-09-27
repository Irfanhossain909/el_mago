import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_progress_line/app_progress_line.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

class RetailerLoyeltyScreen extends StatelessWidget {
  const RetailerLoyeltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppSize.width(value: 16)),
                decoration: BoxDecoration(color: AppColor.blue),
                child: Column(
                  spacing: AppSize.size.height * 0.01,
                  children: [
                    AppText(
                      data: "Loyalty Program",
                      fontSize: AppSize.width(value: 20),
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                    AppText(
                      height: 1.4,
                      data:
                          "Welcome back! Join the Loyalty Program and enjoy exclusive rewards based on your spending.As a member, you will unlock amazing benefits by reaching spending targets.Keep shopping to unlock more rewards and enjoy special discounts!",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                      color: AppColor.white,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        color: AppColor.blackCard,
                      ),
                      padding: EdgeInsets.all(AppSize.width(value: 16)),
                      child: Column(
                        spacing: AppSize.size.height * 0.005,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            data: "Total Spent",
                            fontSize: AppSize.width(value: 12),
                            fontWeight: FontWeight.w500,
                            color: AppColor.white,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                data: r"$1,356",
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w600,
                                color: AppColor.white,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: AppSize.width(value: 24),
                              ),
                            ],
                          ),
                          Gap(height: AppSize.size.height * 0.002),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                data: "Current Target: FREE BOXES",
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w600,
                                color: AppColor.white,
                              ),
                              AppText(
                                data: r"$1,356 / $2,500",
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w600,
                                color: AppColor.white,
                              ),
                            ],
                          ),
                          AppProgressLine(
                            progressColor: AppColor.blue,
                            height: 8,
                            maxValue: 100,
                            currentValue: 60,
                          ),
                          AppText(
                            textAlign: TextAlign.left,
                            data: r"Spend $1,144 more to unlock this reward",
                            fontSize: AppSize.width(value: 16),
                            fontWeight: FontWeight.w600,
                            color: AppColor.white,
                          ),
                          Gap(height: AppSize.size.height * 0.002),
                          AppText(
                            data: "Member Since",
                            fontSize: AppSize.width(value: 16),
                            fontWeight: FontWeight.w400,
                            color: AppColor.white,
                          ),
                          AppText(
                            textAlign: TextAlign.left,
                            data: "July 2025",
                            fontSize: AppSize.width(value: 16),
                            fontWeight: FontWeight.w400,
                            color: AppColor.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                data: "MEMBER#321404",
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                              AppText(
                                data: "0 rewards redeemed",
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: AppSize.size.height * 0.01,
                  children: [
                    //loyalty card one
                    LoyeltyCardOne(),
                    //loyalty card two
                    LoyeltyCardTwo(),
                    //loyalty card three
                    LoyeltyCardThree(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoyeltyCardThree extends StatelessWidget {
  const LoyeltyCardThree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.width(value: 16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: AppColor.orange),
        color: AppColor.orange.withValues(alpha: 0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSize.size.width * 0.04,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(AppSize.width(value: 8)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.orange.withValues(alpha: 0.3),
              ),
              child: AppImage(
                width: AppSize.width(value: 22),
                iconColor: AppColor.black,
                path: AssetsPath.box,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppText(
                          data: "FREE BOXES",
                          fontSize: AppSize.width(value: 16),
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                        Gap(width: AppSize.width(value: 4)),
                        Icon(
                          size: AppSize.width(value: 16),
                          Icons.watch_later_outlined,
                          color: AppColor.orange,
                        ),
                      ],
                    ),
                    AppText(
                      data: "3 Free Boxes",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w600,
                      color: AppColor.blue,
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: "Applies towards your order",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    SizedBox(),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: r"Target: $2,500",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    AppText(
                      data: "65%",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                AppProgressLine(
                  maxValue: 2500,
                  currentValue: 1000,
                  height: 8,
                  progressColor: AppColor.orange,
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColor.orange.withValues(
                          alpha: 0.2,
                        ),
                      ),
                      child: AppText(
                        data: "Running",
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(value: 16),
                        vertical: AppSize.width(value: 12),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.orange,
                      ),
                      child: AppText(
                        data: "Redeem Now",
                        fontSize: AppSize.width(value: 20),
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoyeltyCardTwo extends StatelessWidget {
  const LoyeltyCardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.width(value: 16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: AppColor.orange),
        color: AppColor.orange.withValues(alpha: 0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSize.size.width * 0.04,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(AppSize.width(value: 8)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.orange.withValues(alpha: 0.3),
              ),
              child: AppImage(
                width: AppSize.width(value: 22),
                iconColor: AppColor.black,
                path: AssetsPath.box,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppText(
                          data: "FREE BOXES",
                          fontSize: AppSize.width(value: 16),
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                        Gap(width: AppSize.width(value: 4)),
                        Icon(
                          size: AppSize.width(value: 16),
                          Icons.watch_later_outlined,
                          color: AppColor.orange,
                        ),
                      ],
                    ),
                    AppText(
                      data: "3 Free Boxes",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w600,
                      color: AppColor.blue,
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: "Applies towards your order",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    SizedBox(),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: r"Target: $2,500",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    AppText(
                      data: "65%",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                AppProgressLine(
                  maxValue: 2500,
                  currentValue: 1000,
                  height: 8,
                  progressColor: AppColor.orange,
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColor.orange.withValues(alpha: 0.2),
                      ),
                      child: AppText(
                        data: "Running",
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(value: 16),
                        vertical: AppSize.width(value: 12),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.orange,
                      ),
                      child: AppText(
                        data: "Redeem Now",
                        fontSize: AppSize.width(value: 20),
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoyeltyCardOne extends StatelessWidget {
  const LoyeltyCardOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.width(value: 16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: AppColor.blue),
        color: AppColor.blue.withValues(alpha: 0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSize.size.width * 0.04,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(AppSize.width(value: 12)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.blueLight,
              ),
              child: AppImage(
                width: AppSize.width(value: 12),
                iconColor: AppColor.black,
                path: AssetsPath.gift,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: "FREE CUBAN COFFEE MAKER",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    AppText(
                      data: "\$0",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w600,
                      color: AppColor.blue,
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: "Limited edition",
                      fontSize: AppSize.width(value: 12),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    SizedBox(),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      data: r"Target: $1,000",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    AppText(
                      data: "100%",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                AppProgressLine(
                  maxValue: 1000,
                  currentValue: 1000,
                  height: 8,
                  progressColor: AppColor.blue,
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColor.blueLight,
                      ),
                      child: AppText(
                        data: "Available",
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.width(value: 16),
                        vertical: AppSize.width(value: 12),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.blue,
                      ),
                      child: AppText(
                        data: "Redeem Now",
                        fontSize: AppSize.width(value: 20),
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
