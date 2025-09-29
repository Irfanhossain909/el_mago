import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

class SalesRepresentativeHistory extends StatelessWidget {
  final VoidCallback? onTap;

  const SalesRepresentativeHistory({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppSize.size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.width(value: 16)),
          border: Border.all(color: AppColor.black.withValues(alpha: 0.1)),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(value: 16),
          vertical: AppSize.width(value: 12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildOrderDetails(title: "Order ID", value: "Product Name"),
            SizedBox(height: AppSize.size.height * 0.01),
            buildOrderDetails(title: "Retailer Name", value: "Product Name"),
            SizedBox(height: AppSize.size.height * 0.01),
            buildOrderDetails(title: "Retailer Email", value: "Product Name"),
            SizedBox(height: AppSize.size.height * 0.01),
            buildOrderDetails(title: "Sales Rep Name", value: "Product Name"),
            SizedBox(height: AppSize.size.height * 0.01),
            buildOrderDetails(
              title: "Total Boxes Ordered",
              value: "Product Name",
            ),
            SizedBox(height: AppSize.size.height * 0.01),
            buildOrderDetails(title: "Amount", value: "Product Name"),
            SizedBox(height: AppSize.size.height * 0.01),
            buildOrderDetails(title: "Status", value: "Product Name"),
            SizedBox(height: AppSize.size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: "",
                  fontSize: AppSize.width(value: 16),
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
                const SizedBox(),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        AppSize.width(value: 6),
                      ),
                      color: AppColor.blue,
                    ),
                    child: AppText(
                      data: "View Details",
                      fontSize: AppSize.width(value: 16),
                      color: AppColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOrderDetails({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          data: title,
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w600,
          color: AppColor.black,
        ),
        AppText(
          data: value,
          fontSize: AppSize.width(value: 16),
          fontWeight: FontWeight.w400,
          color: AppColor.black,
        ),
      ],
    );
  }
}
