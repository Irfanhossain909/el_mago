import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final double? padding;
  final double? borderRedius;
  final Function()? onTap;
  final Color? filColor;
  final double? height;
  const AppCard({
    super.key,
    required this.child,
    this.padding,

    this.borderRedius,
    this.onTap,
    this.filColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: EdgeInsets.all(AppSize.width(value: padding ?? 16)),
        width: AppSize.width(value: double.infinity),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07), // ছায়ার রঙ ও অপাসিটি
              offset: Offset(0, 2), // শুধুমাত্র নিচে ছায়া (x=0, y=4)
              blurRadius: 2, // ছায়ার ধোঁয়াশা
              spreadRadius: 0, // ছায়া কতটা ছড়াবে
            ),
          ],
          color: filColor ?? AppColor.white,
          borderRadius: BorderRadius.circular(borderRedius ?? 12),
        ),
        child: child,
      ),
    );
  }
}
