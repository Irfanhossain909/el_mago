import 'package:el_mago/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading extends StatelessWidget {
  final double? size;
  final Color? color;
  const AppLoading({super.key, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SpinKitDualRing(
      color: color ?? AppColor.blue500,
      size: size ?? 50.0,
    );
  }
}
