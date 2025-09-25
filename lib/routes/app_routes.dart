class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;
  /////////////  initial or splash screen
  final String initial = "/";
  final String retailerNavigationScreen = "/retailer-navigation-screen";
  final String salesNavigationScreen = "/sales-navigation-screen";
  final String signupScreen = "/sign-up-screen";
  final String signinScreen = "/sign-in-screen";
  final String forgetPasswordScreen = "/forget-password-screen";
  final String otpVerifyScreen = "/otp-verify-screen";
  final String forgetPassOtpVerifyScreen = "/forgetpass-otp-verify-screen";
  final String createNewPassScreen = "/create-new-pass-screen";
  final String profileScreen = "/profile-screen";
  final String termScreen = "/term-screen";
  final String privicyScreen = "/privicy-screen";
  final String changeProfileScreen = "/change-profile-screen";
  final String changePasswordScreen = "/change-password-screen";
  final String retailerDashboardScreen = "/retailer-dashboard-screen";
  final String retailerShoppingCartScreen = "/retailer-shopping-cart-screen";
  final String retailerMyOrderScreen = "/retailer-my-order-screen";
  final String retailerOrderDetailsScreen = "/retailer-order-details-screen";
  final String salesDashboardScreen = "/sales-dashboard-screen";
  final String salesShoppingCartScreen = "/sales-shopping-cart-screen";
}
