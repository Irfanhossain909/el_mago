import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:flutter/foundation.dart';

class AppApiEndPoint {
  AppApiEndPoint._privateConstructor();
  static final AppApiEndPoint _instance = AppApiEndPoint._privateConstructor();
  static AppApiEndPoint get instance => _instance;

  //app use base
  static final String domain = _getDomain();
  final String baseUrl = "$domain/api/v1";
  ////////////////////// Sales Product Dashboard
  final String getProducts = "/retailer/dashboard/get-products";
  final String getMyRetailers = "/sales/dashboard/my-retailers";
  final String createOrder = "/retailer/dashboard/create";
  final String getMyOrders = "/sales/orders/my-order";
  final String getTotalEarnCommision = "/sales/commission";
  final String getCommissionOrders = "/sales/commission/order";
  final String getMySales = "/sales/my-sales";
  final String createRetailer = "/admin/retailer/managment/create";
  final String deleteRetailer = "/admin/retailer/managment/delete/";
  final String getSingleRetailerDetails = "/admin/retailer/managment/";
  final String getSingleRetailerDetailsAnalysis =
      "/sales/dashboard/my-retailer/details/analysis/";
  final String getSingleRetailerCardDetails =
      "/sales/dashboard/my-retailer/details/";
  final String updateSingleRetailerCardDetails =
      "/sales/dashboard/my-retailer/update/";
  final String getSalesAllretailerSubcription =
      "/sales/dashboard/my-retailers-details";

  ////////////////////// Retailer Product Dashboard
  final String getMyOrdersRetailer = "/retailer/dashboard/orders";
  final String getRetailerDashboardSummary = "/retailer/dashboard/summary";
  final String getRetailerSubscription = "/retailer/subscription/";
  final String getCurrentSubscription = "/retailer/subscription/current";
  final String getMyRewards = "/retailer/loyalty/my-reward";
  static String getSingleRetailerOrder(String orderId) =>
      "/retailer/dashboard/orders/$orderId";
  static String updateExtraBoxes(String userId) =>
      "/retailer/subscription/update-boxes/$userId";

  final String refreshToken = "/auth/refresh-token";
  final String user = "/user";
  final String privacyPolicy = "/others/privacy-policy";
  final String termsAndConditions = "/others/terms-and-conditions";
  final String faq = "/others/faq";
  final String deleteAccount = "/auth/delete-account";

  ////////////////////// auth
  final String authLogin = "/auth/login";
  final String signup = "/users";
  final String verifyEmail = "/auth/verify-email";
  final String resendOtp = "/auth/resend-otp";
  final String forgetPassword = "/auth/forget-password";
  final String resetPassword = "/auth/reset-password";
  final String changePassword = "/auth/change-password";
  final String googleAuthLogin = "/user/google-auth";

  /////////////////////App body
  final String profile = "/users/profile";

  ///////////////////// payment related
  final String payment = "/payment/create-session";
  // final String paymentDashboard = "/payment/dashboard";
  ///////////////////// vendor

  /////////////////////  message or conversion
  final String chatList = "/chat";
  final String sendMsg = "/message";
  static String getMessage(var page, var limit, String iD) =>
      "/message/$iD?page=$page&limit=$limit";
  static String search(var text) => "/wcservice?search=$text";
  final String specificCategoryService = "/service/";
}

// Move this function outside the class
String _getDomain() {
  String liveServer = "http://10.10.7.62:5003";
  String localServer = "http://10.10.7.62:5003";
  try {
    if (kDebugMode) {
      return localServer;
    }
    return liveServer;
  } catch (e) {
    errorLog("_getDomain", e);
    return liveServer;
  }
  // return liveServer;
}
