import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/routes/bindings/app_binding.dart';
import 'package:el_mago/screens/auth/forgetpass_verify_otp_screen/forgetpass_verify_otp_screen.dart';
import 'package:el_mago/screens/notification_screen/notification_screen.dart';
import 'package:el_mago/screens/retailer_complate_subscription_screen/retailer_complate_subscription_screen.dart';
import 'package:el_mago/screens/retailer_loyelty_screen/retailer_loyelty_screen.dart';
import 'package:el_mago/screens/retailer_my_subscription_screen/retailer_my_subscription_screen.dart';
import 'package:el_mago/screens/retailer_select_extrabox_screen/retailer_select_extrabox_screen.dart';
import 'package:el_mago/screens/sales_my_sales_screen/sales_my_sales_screen.dart';
import 'package:el_mago/screens/sales_reppesentative_details/sales_reppesentative_details.dart';
import 'package:get/get.dart';
import 'package:el_mago/screens/retailer_navigation_screen/retailer_navigation_screen.dart';
import 'package:el_mago/screens/auth/create_your_password_screen/create_your_password_screen.dart';
import 'package:el_mago/screens/auth/forget_pass_screen/forget_pass_screen.dart';
import 'package:el_mago/screens/auth/sign_in_screen/sign_in_screen.dart';
import 'package:el_mago/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:el_mago/screens/auth/splash_screen/splash_screen.dart';
import 'package:el_mago/screens/auth/verify_otp_screen/verify_otp_screen.dart';
import 'package:el_mago/screens/chnage_pass_screen/change_pass_screen.dart';
import 'package:el_mago/screens/chnage_profile_info/chnage_profile_screen.dart';
import 'package:el_mago/screens/privicy_screen/privicy_screen.dart';
import 'package:el_mago/screens/profile_screen/profile_screen.dart';
import 'package:el_mago/screens/retailer_dash_board/retailer_dash_board.dart';
import 'package:el_mago/screens/retailer_my_order_screen/retailer_my_order_screen.dart';
import 'package:el_mago/screens/retailer_order_details_screen/retailer_order_details_screen.dart';
import 'package:el_mago/screens/retailer_shopping_cart/retailer_shopping_cart.dart';
import 'package:el_mago/screens/sales_dash_board/sales_dash_board_screen.dart';
import 'package:el_mago/screens/sales_my_order/sales_my_order_screen.dart';
import 'package:el_mago/screens/sales_navigation_screen/sales_navigation_screen.dart';
import 'package:el_mago/screens/sales_order_details_screen/sales_order_details_screen.dart';
import 'package:el_mago/screens/sales_shopping_cart/sales_shopping_cart_screen.dart';
import 'package:el_mago/screens/terms_screen/terms_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  //   /////////////////  splash screen start
  GetPage(
    name: AppRoutes.instance.initial,
    binding: AppBinding(),
    page: () => const SplashScreen(),
    transitionDuration: Duration(milliseconds: 800),
    opaque: false,
  ),
  GetPage(
    name: AppRoutes.instance.retailerNavigationScreen,
    binding: AppBinding(),
    page: () => const RetailerNavigationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.createNewPassScreen,
    binding: AppBinding(),
    page: () => const CreatePasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerNavigationScreen,
    binding: AppBinding(),
    page: () => const RetailerNavigationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.salesNavigationScreen,
    binding: AppBinding(),
    page: () => const SalesNavigationScreen(),
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
    name: AppRoutes.instance.forgetPassOtpVerifyScreen,
    binding: AppBinding(),
    page: () => const ForgetPassVerifyOtpScreen(),
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
  GetPage(
    name: AppRoutes.instance.retailerShoppingCartScreen,
    binding: AppBinding(),
    page: () => const RetailerShoppingCart(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerMyOrderScreen,
    binding: AppBinding(),
    page: () => const RetailerMyOrderScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerOrderDetailsScreen,
    binding: AppBinding(),
    page: () => const RetailerOrderDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.salesDashboardScreen,
    binding: AppBinding(),
    page: () => const SalesDashBoardScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.salesShoppingCartScreen,
    binding: AppBinding(),
    page: () => const SalesShoppingCartScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.salesMyOrderScreen,
    binding: AppBinding(),
    page: () => const SalesMyOrderScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.salesOrderDetailsScreen,
    binding: AppBinding(),
    page: () => const SalesOrderDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerSubscriptionScreen,
    binding: AppBinding(),
    page: () => const RetailerMySubscriptionScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerLoyaltyScreen,
    binding: AppBinding(),
    page: () => const RetailerLoyeltyScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.notificationScreen,
    binding: AppBinding(),
    page: () => const NotificationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerSelectExtraBoxScreen,
    binding: AppBinding(),
    page: () => const RetailerSelectExtraboxScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.retailerComplateSubscriptionScreen,
    binding: AppBinding(),
    page: () => const RetailerComplateSubscriptionScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.salesRepresentativeDetailsScreen,
    binding: AppBinding(),
    page: () => const SalesReppesentativeDetails(),
  ),
];
