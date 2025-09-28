import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/assets_icons_path.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_image/app_image.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:flutter/material.dart';

class SubManageCard extends StatelessWidget {
  final String? name;
  final String? email;
  final String? address;
  final String? text;
  final VoidCallback? subCart;
  final VoidCallback? subEdit;
  const SubManageCard({
    super.key,
    this.name,
    this.email,
    this.address,
    this.text,
    this.subCart,
    this.subEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.black.withValues(alpha: 0.1)),
        ),
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: AppSize.size.height * 0.005,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  data:name ?? "no text",
                  fontSize: AppSize.width(value: 14),
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                AppText(
                  data:email ?? "no text",
                  fontSize: AppSize.width(value: 10),
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
                AppText(
                  data:address ?? "no text",
                  fontSize: AppSize.width(value: 10),
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
                AppText(
                  data: text ?? "no text",
                  fontSize: AppSize.width(value: 10),
                  fontWeight: FontWeight.w400,
                  color: AppColor.black,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.width(value: 8),
                vertical: AppSize.width(value: 6),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.blue500),
              ),
              child: Row(
                spacing: AppSize.width(value: 12),
                children: [
                  InkWell(
                    onTap: subEdit,
                    child: AppImage(
                      width: AppSize.width(value: 20),
                      path: AssetsPath.editIcon,
                    ),
                  ),
                  InkWell(
                    onTap: subCart,
                    child: AppImage(
                      width: AppSize.width(value: 20),
                      path: AssetsPath.cart,
                      iconColor: AppColor.blue,
                    ),
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
