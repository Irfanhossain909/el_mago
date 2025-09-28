import 'package:el_mago/screens/auth/create_your_password_screen/controller/create_your_password_controller.dart';
import 'package:el_mago/screens/auth/forget_pass_screen/controller/forget_password_controller.dart';
import 'package:el_mago/screens/auth/forgetpass_verify_otp_screen/controller/forgetpass_verify_otp_controller.dart';
import 'package:el_mago/screens/auth/sign_in_screen/controller/signin_controller.dart';
import 'package:el_mago/screens/auth/sign_up_screen/controller/signup_controller.dart';
import 'package:el_mago/screens/auth/splash_screen/controller/splash_controller.dart';
import 'package:el_mago/screens/auth/verify_otp_screen/controller/verify_otp_controller.dart';
import 'package:el_mago/screens/chnage_pass_screen/controller/chnage_password_controller.dart';
import 'package:el_mago/screens/chnage_profile_info/controller/chnage_profile_controller.dart';
import 'package:el_mago/screens/controller/global_controller.dart';
import 'package:el_mago/screens/profile_screen/controller/profile_controller.dart';
import 'package:el_mago/screens/retailer_dash_board/controller/retailer_dash_board_controller.dart';
import 'package:el_mago/screens/retailer_my_order_screen/controller/retailer_my_order_screen_controller.dart';
import 'package:el_mago/screens/retailer_my_subscription_screen/controller/retailer_my_subscription_controller.dart';
import 'package:el_mago/screens/retailer_navigation_screen/controller/retailer_navigation_screen_controller.dart';
import 'package:el_mago/screens/retailer_order_details_screen/controller/retailer_order_details_screen_controller.dart';
import 'package:el_mago/screens/retailer_select_extrabox_screen/controller/retailer_select_extrabox_controller.dart';
import 'package:el_mago/screens/retailer_shopping_cart/controller/retailer_shopping_cart_controller.dart';
import 'package:el_mago/screens/sales_commision_breakdown/controller/sales_commition_breackdown_controller.dart';
import 'package:el_mago/screens/sales_dash_board/controller/sales_dashboard_controller.dart';
import 'package:el_mago/screens/sales_my_order/controller/sales_my_order_controller.dart';
import 'package:el_mago/screens/sales_navigation_screen/controller/sales_navigation_screen_controller.dart';
import 'package:el_mago/screens/sales_order_details_screen/controller/sales_order_details_controller.dart';
import 'package:el_mago/screens/sales_shopping_cart/controller/sales_shopping_cart_controller.dart';
import 'package:el_mago/services/repository/order_repository.dart';
import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/services/repository/sales_my_order_repository.dart';
import 'package:el_mago/services/repository/sales_repository.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => SplashController());
    ///////////auth
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => SigninController());
    Get.lazyPut(() => VerifyOtpController());
    Get.lazyPut(() => ForgetPasswordController());
    Get.lazyPut(() => ForgetPassVerifyOtpController());
    Get.lazyPut(() => CreateYourPasswordController());
    Get.lazyPut(() => SalesCommitionBreackdownController());
    Get.lazyPut(() => RetailerMySubscriptionController());
    ///////////app
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => ChnagePasswordController());
    Get.lazyPut(() => ChnageProfileController());
    /////Navigations
    Get.lazyPut(() => SalesNavigationScreenController());
    Get.lazyPut(() => RetailerNavigationScreenController());
    //sales dahboard
    Get.lazyPut<GlobalController>(() => GlobalController());
    Get.lazyPut<SalesDashboardController>(
      () => SalesDashboardController(),
      fenix: true,
    );
    //Retailer dashboard
    Get.lazyPut(() => RetailerDashBoardController(), fenix: true);
    Get.lazyPut(() => RetailerMyOrderController(), fenix: true);
    Get.lazyPut(() => RetailerOrderDetailsController(), fenix: true);

    Get.lazyPut(() => RetailerShoppingCartController(), fenix: true);
    Get.lazyPut(() => RetailerSelectExtraboxController(), fenix: true);

    //shopping cart
    Get.lazyPut(() => SalesShoppingCartController(), fenix: true);
    Get.lazyPut(() => SalesMyOrderController(), fenix: true);
    Get.lazyPut(
      () => SalesOrderDetailsController(),
      fenix: true,
    ); // New Controller

    Get.lazyPut(() => SalesRepository());
    Get.lazyPut(() => ProfileRepository());
    Get.lazyPut(() => OrderRepository());
    Get.lazyPut(() => MyOrderRepository(), fenix: true);
    Get.lazyPut(() => RetailerOrderRepository(), fenix: true);
  }
}
