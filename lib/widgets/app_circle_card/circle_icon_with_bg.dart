import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:flutter/material.dart';

class CircleIconWithBg extends StatelessWidget {
  final String? path;
  final VoidCallback? onTap;
  const CircleIconWithBg({super.key, this.path, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSize.width(value: 8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.width(value: 16)),
          color: AppColor.blue,
        ),
        child: AppImage(
          path: path ?? AssetsPath.cart,
          width: AppSize.width(value: 16),
          iconColor: AppColor.white,
        ),
      ),
    );
  }
}
