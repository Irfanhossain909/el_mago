import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/routes/bindings/app_binding.dart';
import 'package:el_mago/screens/app_navigation_screen/retailer_navigation_screen.dart';
import 'package:el_mago/screens/auth/create_your_password_screen/create_your_password_screen.dart';
import 'package:el_mago/screens/auth/forget_pass_screen/forget_pass_screen.dart';
import 'package:el_mago/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:el_mago/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:el_mago/screens/auth/verify_otp_screen/verify_otp_screen.dart';
import 'package:el_mago/screens/chnage_pass_screen/change_pass_screen.dart';
import 'package:el_mago/screens/chnage_profile_info/chnage_profile_screen.dart';
import 'package:el_mago/screens/privicy_screen/privicy_screen.dart';
import 'package:el_mago/screens/profile_screen/profile_screen.dart';
import 'package:el_mago/screens/retailer_dash_board/retailer_dash_board.dart';
import 'package:el_mago/screens/terms_screen/terms_screen.dart';
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
    name: AppRoutes.instance.retailerNavigationScreen,
    binding: AppBinding(),
    page: () => const RetailerNavigationScreen(),
  ),
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
  GetPage(
    name: AppRoutes.instance.createNewPassScreen,
    binding: AppBinding(),
    page: () => const CreatePasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.profileScreen,
    binding: AppBinding(),
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.termScreen,
    binding: AppBinding(),
    page: () => const TermsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.privicyScreen,
    binding: AppBinding(),
    page: () => const PrivicyScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.changeProfileScreen,
    binding: AppBinding(),
    page: () => const ChnageProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.changePasswordScreen,
    binding: AppBinding(),
    page: () => const ChangePassScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerDashboardScreen,
    binding: AppBinding(),
    page: () => const RetailerDashBoard(),
  ),
];
