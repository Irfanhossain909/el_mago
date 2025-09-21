import 'package:get/get.dart';
import 'package:tinnierenee12/routes/app_routes.dart';
import 'package:tinnierenee12/routes/bindings/app_binding.dart';
import 'package:tinnierenee12/routes/bindings/auth_binding.dart';
import 'package:tinnierenee12/screen/add_document_screen/add_document_screen.dart';
import 'package:tinnierenee12/screen/app_navigation_for_client_screen%20copy/app_navigation_for_client_screen.dart';
import 'package:tinnierenee12/screen/app_navigation_screen/navigation_screen.dart';
import 'package:tinnierenee12/screen/auth/create_your_password_screen/create_your_password_screen.dart';
import 'package:tinnierenee12/screen/auth/forget_pass_screen/forget_pass_screen.dart';
import 'package:tinnierenee12/screen/auth/location_screen/location_screen.dart';
import 'package:tinnierenee12/screen/auth/personal_info_screen/personal_info_screen.dart';
import 'package:tinnierenee12/screen/auth/client_business_info_screen/client_business_info_screen.dart';
import 'package:tinnierenee12/screen/auth/sign_in_screen/sign_in_screen.dart';
import 'package:tinnierenee12/screen/auth/sign_up_screen/sign_up_screen.dart';
import 'package:tinnierenee12/screen/auth/verify_otp_screen/verify_otp_screen.dart';
import 'package:tinnierenee12/screen/client_add_shift_screen/client_add_shift_screen.dart';
import 'package:tinnierenee12/screen/client_all_substitute_screen/client_all_substitute_screen.dart';
import 'package:tinnierenee12/screen/client_home_screen/client_home_screen.dart';
import 'package:tinnierenee12/screen/client_shift_screen/client_shift_screen.dart';
import 'package:tinnierenee12/screen/employee_earning_screen/employee_earning_screen.dart';
import 'package:tinnierenee12/screen/employee_find_shift_details_scrteen/employee_find_shift_details_screen.dart';
import 'package:tinnierenee12/screen/employee_find_shift_screen/employee_find_shift_screen.dart';
import 'package:tinnierenee12/screen/employee_home_screen/employee_home_screen.dart';
import 'package:tinnierenee12/screen/employee_personal_info_submit_screen_one/employee_personal_info_submit_screen_one.dart';
import 'package:tinnierenee12/screen/employee_personal_info_submit_screen_three/employee_personal_info_submit_screen_three.dart';
import 'package:tinnierenee12/screen/employee_personal_info_submit_screen_tow/employee_personal_info_submit_screen_two.dart';
import 'package:tinnierenee12/screen/employee_setting_screen/employee_setting_screen.dart';
import 'package:tinnierenee12/screen/employee_shift_details_screen/employee_shift_details_screen.dart';
import 'package:tinnierenee12/screen/employee_shift_screen/employee_shift_screen.dart';
import 'package:tinnierenee12/screen/notification_screen/notification_screen.dart';
import 'package:tinnierenee12/screen/on_boarding_screen1/on_boarding_screen1.dart';
import 'package:tinnierenee12/screen/payment_successfull_screen/payment_successfull_screen.dart';
import 'package:tinnierenee12/screen/privicy_screen/privicy_screen.dart';
import 'package:tinnierenee12/screen/profile_section/chnage_pass_screen/change_pass_screen.dart';
import 'package:tinnierenee12/screen/profile_section/chnage_profile_info/chnage_profile_screen.dart';
import 'package:tinnierenee12/screen/profile_section/contact_us_screen/contact_us_screen.dart';
import 'package:tinnierenee12/screen/profile_section/profile_screen/profile_screen.dart';
import 'package:tinnierenee12/screen/role_selection_screen/role_selection_screen.dart';
import 'package:tinnierenee12/screen/splash_screen/splash_screen.dart';
import 'package:tinnierenee12/screen/subscription_screen/my_sub_screen/my_sub_screen.dart';
import 'package:tinnierenee12/screen/terms_screen/terms_screen.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  //   /////////////////  splash screen start
  GetPage(
    name: AppRoutes.instance.initial,
    binding: AuthBinding(),
    page: () => const SplashScreen(),
    transitionDuration: Duration(milliseconds: 800),
    opaque: false,
  ),

  GetPage(
    name: AppRoutes.instance.navigationScreen,
    binding: AppBinding(),
    page: () => const NavigationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.navigationForClientScreen,
    binding: AppBinding(),
    page: () => const AppNavigationForClientScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.roleSelectionScreen,
    // binding: AppBinding(),
    page: () => const RoleSelectionScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.onBoardingScreen1,
    // binding: AppBinding(),
    page: () => const OnBoardingScreen1(),
  ),
  GetPage(
    name: AppRoutes.instance.signInScreen,
    // binding: SplashScreenBinding(),
    page: () => const SignInScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.forgetPassScreen,
    // binding: SplashScreenBinding(),
    page: () => const ForgetPassScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.createNewScreen,
    // binding: SplashScreenBinding(),
    page: () => const CreatePasswordScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.verifyOtpScreen,
    // binding: SplashScreenBinding(),
    page: () => const VerifyOtpScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.signUpScreen,
    binding: AuthBinding(),
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.locationScreen,
    // binding: AuthBinding(),
    page: () => const LocationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.personalInfoScreen,
    binding: AppBinding(),
    page: () => const PersonalInfoScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.clientBusinessInfoScreen,
    binding: AppBinding(),
    page: () => const ClientBusinessInfoScreen(),
  ),

  ///////////////////////////////Home screen//////////////////////////
  GetPage(
    name: AppRoutes.instance.employeeHome,
    // binding: AppBinding(),
    page: () => const EmployeeHomeScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.clientHomeScreen,
    // binding: AppBinding(),
    page: () => const ClientHomeScreen(),
  ),
  ///////////////////////////////earning screen//////////////////////////
  GetPage(
    name: AppRoutes.instance.employeeEarningScreen,
    // binding: AppBinding(),
    page: () => const EmployeeEarningScreen(),
  ),
  ///////////////////////////////shift screen//////////////////////////
  GetPage(
    name: AppRoutes.instance.clientAddShiftScreen,
    // binding: AppBinding(),
    page: () => const ClientAddShiftScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.employeeFindShiftDetailsScreen,
    // binding: AppBinding(),
    page: () => const EmployeeFindShiftDetailsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.clientShiftScreen,
    binding: AppBinding(),
    page: () => const ClientShiftScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.clientAllSubstituteScreen,
    binding: AppBinding(),
    page: () => const ClientAllSubstituteScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.employeeFindShiftScreen,
    // binding: AppBinding(),
    page: () => const EmployeeFindShiftScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.employeeShiftScreen,
    // binding: AppBinding(),
    page: () => const EmployeeShiftScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.employeeShiftDetailsScreen,
    // binding: AppBinding(),
    page: () => const EmployeeShiftDetailsScreen(),
  ),
  ///////////////////////////////Profile screen//////////////////////////
  ///
  GetPage(
    name: AppRoutes.instance.notification,
    binding: AppBinding(),
    page: () => const NotificationScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.profileScreen,
    // binding: AppBinding(),
    page: () => const ProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.termsCondiScreen,
    // binding: AppBinding(),
    page: () => const TermsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.privicyScreen,
    // binding: AppBinding(),
    page: () => const PrivicyScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.changePassScreen,
    // binding: AppBinding(),
    page: () => const ChangePassScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.contactUsScreen,
    // binding: AppBinding(),
    page: () => const ContactUsScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.changeProfileScreen,
    // binding: AppBinding(),
    page: () => const ChnageProfileScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.employeePersonalInfoSubmitScreen1,
    // binding: AppBinding(),
    page: () => const EmployeePersonalInfoSubmitScreenOne(),
  ),
  GetPage(
    name: AppRoutes.instance.employeePersonalInfoSubmitScreen2,
    // binding: AppBinding(),
    page: () => const EmployeePersonalInfoSubmitScreenTwo(),
  ),
  GetPage(
    name: AppRoutes.instance.employeePersonalInfoSubmitScreen3,
    // binding: AppBinding(),
    page: () => const EmployeePersonalInfoSubmitScreenThree(),
  ),
  GetPage(
    name: AppRoutes.instance.employeeAddMyDocumentScreen,
    // binding: AppBinding(),
    page: () => const AddDocumentScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.employeeSettingScreen,
    // binding: AppBinding(),
    page: () => const EmployeeSettingScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.clientSubscriptionScreen,
    // binding: AppBinding(),
    page: () => const MySubScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.paymentSuccessfullScreen,
    // binding: AppBinding(),
    page: () => const PaymentSuccessfullScreen(),
  ),
];
