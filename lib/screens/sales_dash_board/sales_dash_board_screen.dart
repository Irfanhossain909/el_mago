import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/widgets/app_input/app_input_widget_two.dart';
import 'package:el_mago/widgets/app_text/custom_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

class SalesDashBoardScreen extends StatelessWidget {
  const SalesDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Dashboard Overview',
        autoShowLeading: true,
        action: [
          CircleAvatar(
            backgroundColor: AppColor.blue,
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                AssetsPath.cart,
                color: AppColor.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: AppColor.blue,
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                AssetsPath.notification,
                color: AppColor.white,
                width: 20,
                height: 20,
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppInputWidgetTwo(
                borderColor: AppColor.button,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 12.0,
                ),
                hintText: "Search by Product Name",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
