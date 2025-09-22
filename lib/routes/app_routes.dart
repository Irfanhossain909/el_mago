class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;
  /////////////  initial or splash screen
  final String initial = "/";
  final String signupScreen = "/sign-up-screen";
  final String signinScreen = "/sign-in-screen";
  final String forgetPasswordScreen = "/forget-password-screen";
  final String otpVerifyScreen = "/otp-verify-screen";
  
}
