class AppRoutes {
  AppRoutes._privateConstructor();
  static final AppRoutes _instance = AppRoutes._privateConstructor();
  static AppRoutes get instance => _instance;
  /////////////  initial or splash screen
  final String initial = "/";
  final String roleSelectionScreen = "/role-selection-screen";
  final String onBoardingScreen1 = "/onboarding-screen1";
  final String navigationScreen = "/navigation-screen";
  final String navigationForClientScreen = "/navigation-for-client-screen";
  ///////////////////////////Auth/////////////////////////////////
  final String signInScreen = "/sign-in-screen";
  final String forgetPassScreen = "/forget-pass-screen";
  final String createNewScreen = "/create-new-screen";
  final String verifyOtpScreen = "/verify-otp-screen";
  final String signUpScreen = "/sign-up-screen";
  final String locationScreen = "/location-screen";
  final String personalInfoScreen = "/personal-info-screen";
  final String clientBusinessInfoScreen = "/client-business-info-screen";

  //////////////////////Profile Screen/////////////////////////
  final String notification = "/notification-screen";
  final String profileScreen = "/profile-screen";
  final String termsCondiScreen = "/terms-condi-screen";
  final String privicyScreen = "/privicy-screen";
  final String changePassScreen = "/change-pass-screen";
  final String contactUsScreen = "/contact-us-screen";
  final String changeProfileScreen = "/change-profile-screen";
  //////////////////////Home Screen/////////////////////////
  final String employeeHome = "/employee-home-screen";
  final String clientHomeScreen = "/client-home-screen";
  //////////////////////shift Screen/////////////////////////
  final String employeeShiftScreen = "/employee-shift-screen";
  final String clientShiftScreen = "/client-shift-screen";
  final String clientAllSubstituteScreen = "/client-substitute-screen";
  final String employeeShiftDetailsScreen = "/employee-shift-details-screen";
  //////////////////////earning Screen/////////////////////////
  final String employeeEarningScreen = "/employee-earning-screen";
  //////////////////////Employee findShift Screen/////////////////////////
  final String employeeFindShiftScreen = "/employee-find-shift-screen";
  final String employeeFindShiftDetailsScreen =
      "/employee-find-shift-details-screen";
  //////////////////////add shift Screen/////////////////////////
  final String clientAddShiftScreen = "/client-add-shift-screen";
  ////////////////////////peronal info submit screen/////////////////
  final String employeePersonalInfoSubmitScreen1 =
      "/employee-personal-info-submit-screen1";
  final String employeePersonalInfoSubmitScreen2 =
      "/employee-personal-info-submit-screen2";
  final String employeePersonalInfoSubmitScreen3 =
      "/employee-personal-info-submit-screen3";
  final String employeeAddMyDocumentScreen = "/employee-add-my-document-screen";
  final String employeeSettingScreen = "/employee-setting-screen";
  final String clientSubscriptionScreen = "/client_subcription-screen";
  final String paymentSuccessfullScreen = "/payment-successfull-screen";
}
