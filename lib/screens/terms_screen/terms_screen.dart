import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'controller/terms_screen_controller.dart';

/*
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Terms & conditions"),
      body: Center(
        child: AppImage(
          width: AppSize.size.width * 0.6,
          path: AssetsPath.termsImg,
        ),
      ),
    );
  }
}
*/

class TermsScreen extends StatelessWidget {
  TermsScreen({super.key});

  final TermsAndConditionsController controller = Get.put(
    TermsAndConditionsController(),
  );

  @override
  Widget build(BuildContext context) {
    final name = Get.arguments['pageTitle'];
    return Scaffold(
      appBar: CustomAppbar(title: name),

      body: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.tarms!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage(
                    width: AppSize.size.width * 0.6,
                    path: AssetsPath.termsImg,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Html(
              data: controller.tarms,
              // You'll need flutter_html package for this
              // Or use Text widget if you want plain text
            ),
          );
        }),
      ),
    );
  }
}
