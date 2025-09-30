import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/models/loyelty_model/loyelty_model.dart';
import 'package:el_mago/screens/retailer_loyelty_screen/controller/loyelty_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_progress_line/app_progress_line.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class RetailerLoyeltyScreen extends StatelessWidget {
  const RetailerLoyeltyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoyeltyController>(
      init: LoyeltyController(),
      builder: (controller) {
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    data:
                                        controller
                                            .loyeltyModelData
                                            .value
                                            ?.loyalty
                                            ?.totalSpent
                                            .toString() ??
                                        "--:--",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    data: "Current Target: FREE BOXES",
                                    fontSize: AppSize.width(value: 16),
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.white,
                                  ),
                                  AppText(
                                    data:
                                        "${controller.loyeltyModelData.value?.availableRewards?.first.target}",
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
                                data:
                                    r"Spend $1,144 more to unlock this reward",
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
                                data: formatMonthYear(
                                  controller
                                          .loyeltyModelData
                                          .value
                                          ?.loyalty
                                          ?.memberSince ??
                                      DateTime(2025, 7),
                                ),
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w400,
                                color: AppColor.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    data:
                                        controller
                                            .loyeltyModelData
                                            .value
                                            ?.loyalty
                                            ?.memberId ??
                                        "--:--",
                                    fontSize: AppSize.width(value: 16),
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.white,
                                  ),
                                  AppText(
                                    data:
                                        "${controller.loyeltyModelData.value?.loyalty?.rewardsRedeemed?.length} rewards redeemed",
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
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child:
                          controller
                                  .loyeltyModelData
                                  .value
                                  ?.availableRewards
                                  ?.isNotEmpty ==
                              true
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller
                                      .loyeltyModelData
                                      .value
                                      ?.availableRewards
                                      ?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                final reward = controller
                                    .loyeltyModelData
                                    .value!
                                    .availableRewards![index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: AppSize.size.height * 0.01,
                                  ),
                                  child: LoyeltyCardOne(
                                    isLocked: isLocked(
                                      index: index,
                                      target: reward.target ?? 0,
                                      totalSpend:
                                          controller
                                              .loyeltyModelData
                                              .value
                                              ?.loyalty
                                              ?.totalSpent ??
                                          0,
                                      availableRewards: controller
                                          .loyeltyModelData
                                          .value!
                                          .availableRewards,
                                    ),
                                    status: controller.getStatus(
                                      target: reward.target ?? 0,
                                      totalSpend:
                                          controller
                                              .loyeltyModelData
                                              .value
                                              ?.loyalty
                                              ?.totalSpent ??
                                          0,
                                      current:
                                          controller
                                              .loyeltyModelData
                                              .value
                                              ?.loyalty
                                              ?.totalSpent ??
                                          0,
                                    ),
                                    title: reward.title,
                                    type: reward.type,
                                    description: reward.description,
                                    target: reward.target?.toString(),
                                    value: reward.value?.toString(),
                                    maxValue: reward.target?.toString(),
                                    onTap: () {
                                      controller.redeemProduct(
                                        retailerId: reward.id!,
                                      );
                                    },
                                    targetLeft:
                                        "${controller.remainingToTarget(totalSpend: controller.loyeltyModelData.value?.loyalty?.totalSpent ?? 0, target: reward.target ?? 0)}",

                                    currentValue: controller
                                        .loyeltyModelData
                                        .value
                                        ?.loyalty
                                        ?.totalSpent
                                        ?.toString(),
                                    isRedemed: reward.isRedeemed ?? false,
                                    percentage:
                                        "${controller.calculatePercentage(target: reward.target?.toDouble(), current: controller.loyeltyModelData.value?.loyalty?.totalSpent?.toDouble())}",
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: AppText(
                                data: "No rewards available",
                                fontSize: AppSize.width(value: 16),
                                fontWeight: FontWeight.w500,
                                color: AppColor.black,
                              ),
                            ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isLocked({
    required int index,
    required int target,
    required int totalSpend,
    List<AvailableReward>? availableRewards,
  }) {
    int minimumTarget = 0;
    if (index > 0) {
      minimumTarget = availableRewards?[index - 1].target ?? 0;
    }
    return totalSpend < minimumTarget && target > totalSpend;
  }
}

String formatMonthYear(DateTime dateTime) {
  return DateFormat("MMMM yyyy").format(dateTime);
}

class LoyeltyCardOne extends StatelessWidget {
  final String status;
  final String? title;
  final String? targetLeft;
  final String? type;
  final String? description;
  final String? target;
  final String? value;
  final String? maxValue;
  final String? currentValue;
  final VoidCallback? onTap;
  final bool isRedemed;
  final bool isLocked;

  final String? percentage;
  const LoyeltyCardOne({
    super.key,
    this.title,
    this.type,
    this.description,
    this.target,
    this.value,
    this.isRedemed = false,
    this.maxValue,
    this.currentValue,
    this.onTap,
    this.percentage,
    required this.status,
    this.targetLeft,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.width(value: 16)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: isLocked
            ? Border.all(color: Colors.grey)
            : (status == "Available"
                  ? Border.all(color: AppColor.blue)
                  : Border.all(color: Colors.orange)),
        color: isLocked
            ? Colors.grey.withValues(alpha: 0.2)
            : (status == "Available"
                  ? AppColor.blue.withValues(alpha: 0.2)
                  : AppColor.orange.withValues(alpha: 0.2)),
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
                color: isLocked
                    ? Colors.grey.withValues(alpha: 0.2)
                    : (status == "Available"
                          ? AppColor.blue.withValues(alpha: 0.2)
                          : AppColor.orange.withValues(alpha: 0.2)),
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
                    SizedBox(
                      width: AppSize.width(value: 160),
                      child: AppText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        data: title ?? "noText",
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                    AppText(
                      data: type ?? "\$0",
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
                      data: description ?? "no Text",
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
                      data: "Target: \$${target ?? "0"}",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    AppText(
                      data: "${percentage ?? 0} %",
                      fontSize: AppSize.width(value: 16),
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                  ],
                ),
                Gap(height: AppSize.width(value: 8)),
                AppProgressLine(
                  maxValue: double.parse(maxValue ?? "0"),
                  currentValue: double.parse(currentValue ?? "0"),
                  height: 8,
                  progressColor: isLocked
                      ? Colors.grey.withValues(alpha: 0.2)
                      : (status == "Available"
                            ? AppColor.blue.withValues(alpha: 0.2)
                            : AppColor.orange.withValues(alpha: 0.2)),
                ),
                Gap(height: AppSize.width(value: 8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: isLocked
                            ? Colors.grey.withValues(alpha: 0.2)
                            : (status == "Available"
                                  ? AppColor.blue.withValues(alpha: 0.2)
                                  : AppColor.orange.withValues(alpha: 0.2)),
                      ),
                      child: AppText(
                        data: status,
                        fontSize: AppSize.width(value: 16),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),

                    if (status == "Running")
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 16),
                          vertical: AppSize.width(value: 12),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey,
                        ),
                        child: AppText(
                          data: "$targetLeft More",
                          fontSize: AppSize.width(value: 20),
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),

                    if (status != "Running")
                      isRedemed
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.width(value: 16),
                                vertical: AppSize.width(value: 12),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: CupertinoColors.activeGreen,
                              ),
                              child: AppText(
                                data: "Complate",
                                fontSize: AppSize.width(value: 20),
                                fontWeight: FontWeight.w700,
                                color: AppColor.white,
                              ),
                            )
                          : InkWell(
                              onTap: onTap,
                              child: Container(
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
