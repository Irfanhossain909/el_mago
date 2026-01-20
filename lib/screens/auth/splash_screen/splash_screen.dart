import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/screens/auth/splash_screen/controller/splash_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AppSize.size = size;
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(
            () => Center(
              child: AnimatedOpacity(
                duration: Duration(seconds: 2),
                opacity: controller.animation2.value,
                child: AnimatedScale(
                  scale: controller.animation.value,
                  duration: Duration(seconds: 2),
                  curve: Curves.easeOutExpo,
                  child: AppImage(width: 250, path: AssetsPath.appLogo),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
