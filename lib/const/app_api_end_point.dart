
import 'package:flutter/foundation.dart';
import 'package:tinnierenee12/widget/app_log/error_log.dart';

class AppApiEndPoint {
  AppApiEndPoint._privateConstructor();
  static final AppApiEndPoint _instance = AppApiEndPoint._privateConstructor();
  static AppApiEndPoint get instance => _instance;

  //app use base
  static final String domain = _getDomain();
  final String baseUrl = "$domain/api/v1";
  final String refreshToken = "/auth/refresh-token";
  final String user = "/user";
  final String privacyPolicy = "/others/privacy-policy";
  final String termsAndConditions = "/others/terms-and-conditions";
  final String faq = "/others/faq";
  final String deleteAccount = "/auth/delete-account";

  ////////////////////// auth
  final String authLogin = "/auth/login";
  final String verifyEmail = "/auth/verify-email";
  final String resendOtp = "/user/resend-otp";
  final String forgetPassword = "/auth/forgot-password";
  final String resetPassword = "/auth/reset-password";
  final String changePassword = "/auth/change-password";
  final String googleAuthLogin = "/user/google-auth";
  ////////////////////// user part
  final String getUserRecomendedService = "/wcservice/highest-rated";
  final String getUserAllServiceCategory = "/service";
  final String providerAllService = "/wcservice";
  final String getUserPortfolio = "/portfolio/me";
  final String userBooking = "/booking";
  final String getUserProfile = "/user/profile";
  final String banner = "/banner";
  final String about = "/rule/about";
  final String termsAndCondition = "/rule/terms-and-conditions";
  final String privicyAndPolicy = "/rule/privacy-policy";
  final String faqContent = "/faq/get";
  final String bookmark = "/bookmark";
  final String providerAddService = "/wcservice/create-servicewc";
  final String notification = "/notification/admin";
  final String notificationForCustomer = "/notification";
  final String serviceBooking = "/booking/service-provider/";
  final String statusDataForProvider = "/booking/booking-status";
  final String providerDeleteService = "/wcservice/";
  final String plandetails = "/package";

  ///////////////////// payment related
  final String payment = "/payment/create-session";
  // final String paymentDashboard = "/payment/dashboard";
  ///////////////////// vendor
  final String vendorProfile = "/vendor/profile";
  final String vendorProfileUpdate = "/vendor";
  final String vendorBusinessInformationUpdate = "/vendor/business-information";
  final String vendorStatisticRevenue = "/vendor/statistic/revenue/";
  final String vendorStatisticRetention = "/vendor/statistic/retention/";
  final String vendorStatisticOrder = "/vendor/statistic/order/";
  final String vendorService = "/service";
  final String vendorServiceList = "/service/vendor";
  final String vendorPackage = "/package";
  final String vendorOrderStatus = "/order/user/";
  final String orderAcceptReject = "/order/accept-reject";
  final String vendorOrderStartDelivery = "/order/start-delivery";
  final String servicesForProvider =
      "/booking/admin/booking-status/details?status=";
  final String updateServiceStatus = "/booking/";
  final String getPortFolio = "/portfolio/me/all";
  final String getPortFoliospecificProvider = "/portfolio/me";

  /////////////////////  message or conversion
  final String chatList = "/chat";
  final String sendMsg = "/message";
  static String getMessage(var page, var limit ,String iD) => "/message/$iD?page=$page&limit=$limit";
  static String search(var text,) => "/wcservice?search=$text";
  final String specificCategoryService = "/service/";
}

// Move this function outside the class
String _getDomain() {
  ///////////10.0.70.208:3001///////////////////////
  // String liveServer = "http://10.0.70.208:10.0.70.30:3002";
  // String localServer = "http://10.0.70.208:3001";
  //////////LIVE////////////////////////
  // String liveServer = "http://195.35.9.21:3001";
  // String localServer = "http://10.0.70.30:3002";
  //////////10.0.70.30:3002////////////////////////
  String liveServer = "https://api.flxbookonline.com";
  String localServer = "https://api.flxbookonline.com";
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
