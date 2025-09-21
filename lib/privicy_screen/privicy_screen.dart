import 'package:flutter/material.dart';
import 'package:tinnierenee12/const/assets_icons_path.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_image/app_image.dart';
import 'package:tinnierenee12/widget/appbar/custom_appbar.dart';

class PrivicyScreen extends StatelessWidget {
  const PrivicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Privacy Policy"),
      body: Center(
        child: AppImage(
          width: AppSize.size.width * 0.6,
          path: AssetsPath.termsImg,
        ),
      ),
    );
  }
}
