import 'package:el_mago/const/app_theme.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/routes/app_routes_file.dart';
import 'package:el_mago/routes/bindings/app_binding.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppSize.size = MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.instance.initial,
      // initialRoute: AppRoutes.instance.retailerNavigationScreen,
      getPages: appRootRoutesFile,
      enableLog: true,
      themeMode: ThemeMode.light,
      initialBinding: AppBinding(),

      title: 'El mago',
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 300),
    );
  }
}
