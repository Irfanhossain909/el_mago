import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/retailer_loyelty_screen/retailer_loyelty_screen.dart';
import 'package:el_mago/screens/retailer_my_subscription_screen/retailer_my_subscription_screen.dart';
import 'package:el_mago/screens/retailer_navigation_screen/controller/retailer_navigation_screen_controller.dart';
import 'package:el_mago/screens/profile_screen/profile_screen.dart';
import 'package:el_mago/screens/retailer_dash_board/retailer_dash_board.dart';
import 'package:el_mago/screens/retailer_my_order_screen/retailer_my_order_screen.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerNavigationScreen extends StatelessWidget {
  const RetailerNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RetailerNavigationScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                RetailerDashBoard(),
                RetailerMyOrderScreen(),

                // RetailerMySubscriptionScreen(),
                RetailerLoyeltyScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(value: 20),
              vertical: AppSize.width(value: 20),
            ),
            child: Container(
              // margin: const EdgeInsets.all(16),
              padding: EdgeInsets.only(
                bottom: AppSize.width(value: 10),
                top: AppSize.width(value: 10),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withValues(alpha: .3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                color: AppColor.white,
                borderRadius: BorderRadius.circular(45),
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(4, (index) {
                    final isSelected = controller.selectedIndex.value == index;
                    final iconPaths = [
                      AssetsPath.nav1,
                      AssetsPath.nav5,
                      // AssetsPath.nav2,
                      AssetsPath.nav3,

                      AssetsPath.nav4,
                    ];

                    return InkWell(
                      onTap: () => controller.changeIndex(index),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: isSelected
                            ? BoxDecoration(
                                color: AppColor.blue, // Purple circle
                                shape: BoxShape.circle,
                              )
                            : null,
                        child: AppImage(
                          path: iconPaths[index],
                          width: AppSize.width(value: 24),
                          height: AppSize.width(value: 24),
                          iconColor: isSelected ? Colors.white : AppColor.black,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
