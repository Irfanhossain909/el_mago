import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.autoShowLeading = true,
    this.action, // Optionally pass a title to the AppBar
  });

  final String? title;
  final List<Widget>? action;
  final bool autoShowLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: action,
      backgroundColor: AppColor.white,
      centerTitle: true,
      title: AppText(
        data: title ?? "",
        fontSize: AppSize.width(value: 17),
        color: AppColor.black,
        fontWeight: FontWeight.w700,
      ),
      leading: autoShowLeading
          ? Padding(
              padding: const EdgeInsets.all(18),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.black,
                  size: AppSize.width(value: 18),
                ),
              ),
            )
          : SizedBox(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); // Set the height you want for the AppBar
}
