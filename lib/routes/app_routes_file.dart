
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/routes/bindings/app_binding.dart';
import 'package:el_mago/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  //   /////////////////  splash screen start
  // GetPage(
  //   name: AppRoutes.instance.initial,
  //   binding: AuthBinding(),
  //   page: () => const SplashScreen(),
  //   transitionDuration: Duration(milliseconds: 800),
  //   opaque: false,
  // ),

  GetPage(
    name: AppRoutes.instance.signupScreen,
    binding: AppBinding(),
    page: () => const SignUpScreen(),
  ),
 
];
