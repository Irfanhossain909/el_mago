import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/screens/sales_retailer_management/controller/sales_retailer_management_controller.dart';
import 'package:el_mago/screens/sales_retailer_management/widget/sale_representative_card.dart';
import 'package:el_mago/screens/sales_retailer_management/widget/sub_manage_card.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_button/app_button.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesRetailerManagementScreen extends StatelessWidget {
  const SalesRetailerManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesRetailerManagementController>(
      init: SalesRetailerManagementController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            title: "Retailer Management",
            autoShowLeading: false,
          ),
          body: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    SizedBox(),
                    Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: AppButton(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.instance.salesAddRetailersScreen,
                          );
                        },
                        width: AppSize.size.width * 0.4,
                        title: "Add Retailer +",
                      ),
                    ),
                  ],
                ),
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
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
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
                      Obx(
                        () => controller.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.blue,
                                ),
                              )
                            : controller.retailerOrderList.isEmpty
                            ? Center(
                                child: AppText(
                                  data: "No Retailers Found",
                                  color: AppColor.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.all(
                                  AppSize.width(value: 12),
                                ),
                                itemCount: controller.retailerOrderList.length,
                                itemBuilder: (context, index) {
                                  final retailar =
                                      controller.retailerOrderList[index];
                                  return SalesRepresentativeCard(
                                    name: retailar.name,
                                    email: retailar.email,
                                    address: retailar.address,
                                    retailerDetails: () {
                                      Get.toNamed(
                                        AppRoutes
                                            .instance
                                            .salesRepresentativeDetailsScreen,
                                        arguments: retailar.id,
                                      );
                                    },
                                    retailerEdit: () {
                                      Get.toNamed(
                                        AppRoutes
                                            .instance
                                            .salesEditNewRetailersScreen,
                                        arguments: retailar.id,
                                      );
                                    },
                                    retailerDelete: () {
                                      Get.bottomSheet(
                                        deleteConfirmationSheet(
                                          onDelete: () {
                                            controller.deleteRetailer(
                                              retailerId: retailar.id ?? "",
                                            );
                                            Get.back();
                                          },
                                        ),
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                      );
                                    },
                                    retailerupdate: () {
                                      Get.bottomSheet(
                                        updateStatusSheet(),
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                      //Tab 2
                      ListView.builder(
                        padding: EdgeInsets.all(AppSize.width(value: 12)),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return SubManageCard(
                            subEdit: () {
                              Get.toNamed(
                                AppRoutes.instance.salesEditSubscriptionScreen,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget updateStatusSheet() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Center(
          child: Text(
            "Update Status",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Divider(thickness: 1, color: Colors.black12),
        const SizedBox(height: 16),

        // Dropdown Label
        Text(
          "Status",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),

        // Dropdown
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: "Active",
              items: ["Active", "Deactive"]
                  .map(
                    (status) =>
                        DropdownMenuItem(value: status, child: Text(status)),
                  )
                  .toList(),
              onChanged: (value) {
                // handle dropdown change
              },
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Apply Filters button
        AppButton(title: "Apply Filters"),
      ],
    ),
  );
}

Widget deleteConfirmationSheet({VoidCallback? onDelete}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          height: 1.4,

          data:
              "Are you sure you want to delete testing retailer?\nThis action cannot be undone.",
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w600,
          color: AppColor.black,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Get.back(); // cancel pressed
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: Colors.black12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blue,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Delete",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
