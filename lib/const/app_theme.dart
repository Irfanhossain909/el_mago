import 'package:flutter/material.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/const/app_const.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    // extensions: const [AppThemeColor.light],
    fontFamily: AppConst.fontFamily1,
    scaffoldBackgroundColor: AppColor.purple,
    primaryColor: AppColor.purple,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColor.purple,
      error: Colors.red,
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.purple,
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
      indicatorColor: AppColor.gold,
      height: 80,
      labelTextStyle: WidgetStateTextStyle.resolveWith(
        (states) => TextStyle(
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w600
              : FontWeight.normal,
          fontSize: 12,
          color: states.contains(WidgetState.selected)
              ? AppColor.gold
              : AppColor.gold,
        ),
      ),
    ),
  );

  // static ThemeData darkTheme = ThemeData(
  //   // extensions: const [AppThemeColor.dark],
  //   fontFamily: AppConst.fontFamily1,
  //   scaffoldBackgroundColor: AppColor.surfacePrimaryLight,
  //   primaryColor: AppColor.buttonDark,
  //   colorScheme: const ColorScheme.light(
  //     brightness: Brightness.light,
  //     primary: AppColor.buttonDark,
  //     error: AppColor.buttonDark,
  //   ),
  //   useMaterial3: true,
  //   appBarTheme: const AppBarTheme(
  //     backgroundColor: AppColor.surfacePrimaryDark,
  //     iconTheme: IconThemeData(color: Colors.white),
  //     elevation: 0,
  //     scrolledUnderElevation: 0,
  //     titleTextStyle: TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 20,
  //       color: Colors.white,
  //     ),
  //   ),
  //   textTheme: const TextTheme(
  //     bodyMedium: TextStyle(
  //       color: AppColor.black,
  //       fontFamily:AppConst.fontFamily1,
  //       height: 1.6,
  //     ),
  //   ),
  //   navigationBarTheme: NavigationBarThemeData(
  //     backgroundColor: AppColor.white,
  //     indicatorColor: AppColor.gold,
  //     height: 80,
  //     labelTextStyle: WidgetStateTextStyle.resolveWith(
  //       (states) => TextStyle(
  //         fontWeight:
  //             states.contains(WidgetState.selected)
  //                 ? FontWeight.w600
  //                 : FontWeight.normal,
  //         fontSize: 12,
  //         color:
  //             states.contains(WidgetState.selected)
  //                 ? AppColor.buttonDark
  //                 : AppColor.text2Dark,
  //       ),
  //     ),
  //   )
  //   );
}
