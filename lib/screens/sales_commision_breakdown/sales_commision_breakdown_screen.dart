import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/sales_commision_breakdown/controller/sales_commition_breackdown_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_card/app_card.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_log/gap.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SalesCommisionBreakdownScreen extends StatelessWidget {
  const SalesCommisionBreakdownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesCommitionBreackdownController>(
      init: SalesCommitionBreackdownController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            title: "Commission Breakdown",
            autoShowLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: AppCard(
              padding: 12,
              borderRedius: 0,
              filColor: AppColor.blue,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppSize.size.height * 0.005,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.all(AppSize.width(value: 12)),
                              decoration: BoxDecoration(
                                color: AppColor.blue,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColor.blue),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: AppImage(
                                      width: AppSize.width(value: 24),

                                      path: AssetsPath.dollerColor,
                                    ),
                                  ),
                                  Gap(width: AppSize.width(value: 12)),
                                  Column(
                                    spacing: AppSize.width(value: 8),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        data:
                                            "\$${controller.salesCommitionBreackdown.value}",
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: AppSize.width(value: 16),
                                      ),
                                      AppText(
                                        data: "Total Commission Earned",
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.white,
                                        fontSize: AppSize.width(value: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            AppInputWidgetTwo(
                              borderColor: AppColor.button,
                              hintText: "Search by invoice ID or Product Name",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Gap(height: AppSize.width(value: 12)),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _StickyHeaderDelegate(
                        minHeight: AppSize.width(value: 45),
                        maxHeight: AppSize.width(value: 45),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(8),
                            // border: Border.all(
                            //   color: AppColor.black.withValues(alpha: 0.1),
                            // ),
                          ),

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              // border: Border.all(
                              //   color: AppColor.black.withValues(alpha: 0.1),
                              // ),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppText(
                                  data: "Invoice",
                                  fontSize: AppSize.width(value: 10),
                                  fontWeight: FontWeight.w600,
                                ),
                                AppText(
                                  data: "Quantity",
                                  fontSize: AppSize.width(value: 10),
                                  fontWeight: FontWeight.w600,

                                  textAlign: TextAlign.center,
                                ),
                                AppText(
                                  data: "Price",
                                  fontSize: AppSize.width(value: 10),
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.end,
                                ),
                                AppText(
                                  data: "Commission",
                                  fontSize: AppSize.width(value: 10),
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.end,
                                ),
                                AppText(
                                  data: "Date",
                                  fontSize: AppSize.width(value: 10),
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.end,
                                ),
                                AppText(
                                  data: "Status",
                                  fontSize: AppSize.width(value: 10),
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Gap(height: AppSize.width(value: 12)),
                    ),
                  ];
                },
                body: ListView.builder(
                  itemCount: 10, // Example data
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColor.blue,
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: AppSize.width(value: 16),
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              data: "INV#5022",
                              fontSize: AppSize.width(value: 12),
                              color: AppColor.white,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              data: "14",
                              fontSize: AppSize.width(value: 12),
                              textAlign: TextAlign.center,
                              color: AppColor.white,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              data: r"$1104.00",
                              fontSize: AppSize.width(value: 12),
                              textAlign: TextAlign.end,
                              color: AppColor.white,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              data: r"$165.60",
                              fontSize: AppSize.width(value: 12),
                              textAlign: TextAlign.end,
                              color: AppColor.white,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              data: "08/09/25",
                              fontSize: AppSize.width(value: 12),
                              textAlign: TextAlign.end,
                              color: AppColor.white,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              data: "delivered",
                              fontSize: AppSize.width(value: 12),
                              textAlign: TextAlign.end,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
