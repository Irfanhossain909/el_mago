import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/routes/bindings/app_binding.dart';
import 'package:el_mago/screens/auth/forget_pass_screen/forget_pass_screen.dart';
import 'package:el_mago/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:el_mago/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:el_mago/screens/auth/verify_otp_screen/verify_otp_screen.dart';
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
  GetPage(
    name: AppRoutes.instance.signinScreen,
    binding: AppBinding(),
    page: () => const SignInScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.forgetPasswordScreen,
    binding: AppBinding(),
    page: () => const ForgetPassScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.otpVerifyScreen,
    binding: AppBinding(),
    page: () => const VerifyOtpScreen(),
  ),
];
