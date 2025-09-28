import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/sales_retailer_management/widget/sale_representative_card.dart';
import 'package:el_mago/screens/sales_retailer_management/widget/sub_manage_card.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SalesRetailerManagementScreen extends StatelessWidget {
  const SalesRetailerManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Retailer Management",
        autoShowLeading: false,
      ),
      body: DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorPadding: EdgeInsets.symmetric(vertical: 20),
              dividerColor: Colors.transparent,
              labelColor: AppColor.blue, // Active tab text color (blue)
              unselectedLabelColor: Colors.black, // Inactive tab text color
              indicatorColor:
                  AppColor.blue, // Active tab underline color (blue)
              indicatorWeight: 2.0, // Underline thickness
              labelPadding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: "Sales Representatives"),
                Tab(text: "Subscription Management"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  //Tab 1
                  ListView.builder(
                    padding: EdgeInsets.all(AppSize.width(value: 12)),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return SalesRepresentativeCard(
                        retailerDetails: () {
                          Get.toNamed(
                            AppRoutes.instance.salesRepresentativeDetailsScreen,
                          );
                        },
                      );
                    },
                  ),
                  //Tab 2
                  ListView.builder(
                    padding: EdgeInsets.all(AppSize.width(value: 12)),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return SubManageCard();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
