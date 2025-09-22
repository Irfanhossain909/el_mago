import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/const/app_const.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    // extensions: const [AppThemeColor.light],
    fontFamily: AppConst.fontFamily1,
    scaffoldBackgroundColor: AppColor.white,
    primaryColor: AppColor.white,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColor.white,
      error: Colors.red,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.white,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: AppColor.black,
        fontFamily: AppConst.fontFamily1,
        height: 1.6,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColor.white,
      indicatorColor: AppColor.button,
      height: 80,
      labelTextStyle: WidgetStateTextStyle.resolveWith(
        (states) => TextStyle(
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w600
              : FontWeight.normal,
          fontSize: 12,
          color: states.contains(WidgetState.selected)
              ? AppColor.button
              : AppColor.button,
        ),
      ),
    ),
  );

  }
