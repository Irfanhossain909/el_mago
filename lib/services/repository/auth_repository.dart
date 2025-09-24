import 'package:dio/dio.dart';
import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/services/api/app_in_put_unfocused.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/services/api/non_auth_api.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:get/get.dart';

class AuthRepository {
  NonAuthApi nonAuthApi = NonAuthApi();
  AuthRepository._();

  static final AuthRepository instance = AuthRepository._();
  GetStorageServices storageServices = GetStorageServices.instance;

  Future<bool> login({required String email, required String password}) async {
    try {
      Map<String, String> body = {"email": email, "password": password};
      appInPutUnfocused();
      var response = await nonAuthApi.sendRequest.post(
        AppApiEndPoint.instance.authLogin,
        data: body,
      );
      if (response.statusCode == 200 && response.data != null) {
        String accessToken = response.data["data"]["accessToken"];
        storageServices.setToken(accessToken);

        return true;
      } else {
        // Handle the error if the response or data is null
        AppPrint.apiResponse("Error: Access Token not found!");
      }

      return false;
    } on DioException catch (error) {
      if (error.response?.data["message"].runtimeType != null) {
        Get.snackbar(
          "error",
          "${error.response?.data["message"] ?? "Something went wrong"}",
        );
      }
      return false;
    } catch (e) {
      errorLog("login", e);
      return false;
    }
  }

  Future<bool> forgetEmailSend({required String email}) async {
    Map<String, String> body = {"email": email};
    try {
      var response = await nonAuthApi.sendRequest.post(
        AppApiEndPoint.instance.resendOtp,
        data: body,
      );
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      AppPrint.appError(e, title: "forgetEmailSend");
    }
    return false;
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String address,
    required String password,
    required String role,
  }) async {
    try {
      Map<String, String> body = {
        "name": name,
        "email": email,
        "address": address,
        "password": password,
        "role": role,
      };
      appInPutUnfocused();
      var response = await nonAuthApi.sendRequest.post(
        AppApiEndPoint.instance.signup,
        data: body,
      );
      AppPrint.apiResponse(response);
      if (response.statusCode == 200) {
        AppPrint.apiResponse(response.data["data"]["role"]);
        storageServices.setUserRole(response.data["data"]["role"]);
        String role = storageServices.getUserRole();
        AppPrint.apiResponse(role, title: "Store Roll");
        appInPutUnfocused();
        return true;
      } else {
        appInPutUnfocused();
        return false;
      }
    } on DioException catch (error) {
      if (error.response?.data["message"].runtimeType != null) {
        Get.snackbar(
          "error",
          "${error.response?.data["message"] ?? "Something went wrong"}",
        );
      }
      return false;
    } catch (e) {
      errorLog("signUp", e);
      return false;
    }
  }

  Future<bool> emailVerify({required String email, required int otp}) async {
    Map<String, dynamic> body = {"email": email, "oneTimeCode": otp};
    try {
      var response = await nonAuthApi.sendRequest.post(
        AppApiEndPoint.instance.verifyEmail,
        data: body,
      );
      if (response.statusCode == 200 && response.data != null) {
        String accessToken = response.data["data"]["accessToken"];
        storageServices.setToken(accessToken);
        AppPrint.apiResponse(storageServices.getToken(), title: "Store Token");
        return true;
      } else {
        // Handle the error if the response or data is null
        AppPrint.apiResponse("Error: Access Token not found!");
      }

      return false;
    } catch (e) {
      AppPrint.appError(e.toString(), title: "Email Verify");
    }
    return false;
  }

  Future<dynamic> forgetEmailVerify({
    required String email,
    required int otp,
  }) async {
    Map<String, dynamic> body = {"email": email, "oneTimeCode": otp};
    try {
      var response = await nonAuthApi.sendRequest.post(
        AppApiEndPoint.instance.verifyEmail,
        data: body,
      );
      if (response.statusCode == 200 && response.data != null) {
        AppPrint.apiResponse(
          response.data["data"]["verifyToken"],
          title: "Reset Token",
        );
        // String resetToket = response.data["data"]["accessToken"];
        // AppPrint.apiResponse(storageServices.getToken(), title: "Store Token");
        return response.data["data"]["verifyToken"];
      } else {
        // Handle the error if the response or data is null
        AppPrint.apiResponse("Error: Access Token not found!");
      }

      return false;
    } catch (e) {
      AppPrint.appError(e.toString(), title: "Email Verify");
    }
    return false;
  }

  // Future<dynamic> emailVerifyFormForgetPass({required String email, required String otp}) async {
  //   Map<String, dynamic> body = {"email": email, "oneTimeCode": otp};
  //   try {
  //     var response = await nonAuthApi.sendRequest.post(AppApiEndPoint.instance.verifyOtp, data: body);
  //     if (response.statusCode == 200 && response.data != null) {
  //       String resendToken = response.data["data"]["resetToken"];
  //       storageServices.setResetToken(resendToken);
  //       AppPrint.apiResponse("Reset Tiken ${storageServices.getResetToken()}");
  //       return true;
  //     } else {
  //       // Handle the error if the response or data is null
  //       AppPrint.apiResponse("Error: Access Token not found!");
  //     }

  //     return false;
  //   } catch (e) {
  //     AppPrint.appError(e.toString(), title: "Email Verify");
  //   }
  //   return false;
  // }

  // Future<bool> forgetEmailSend({required String email}) async {
  //   Map<String, String> body = {"email": email};
  //   try {
  //     var response = await nonAuthApi.sendRequest.post(AppApiEndPoint.instance.forgetPassword, data: body);
  //     if (response.statusCode == 200) {
  //       return true;
  //     }
  //   } catch (e) {
  //     AppPrint.appError(e, title: "forgetEmailSend");
  //   }
  //   return false;
  // }

  // Future<bool> forgetEmailVerify({required String email, required String otp}) async {
  //   Map<String, dynamic> body = {"email": email, "oneTimeCode": otp};
  //   try {
  //     var response = await nonAuthApi.sendRequest.post(AppApiEndPoint.instance.verifyOtp, data: body);
  //     if (response.statusCode == 200 && response.data != null) {
  //       // String accessToken = response.data["data"]["accessToken"];
  //       // storageServices.setToken(accessToken);
  //       // AppPrint.apiResponse(storageServices.getToken(), title: "Store Token");
  //       return true;
  //     } else {
  //       // Handle the error if the response or data is null
  //       AppPrint.apiResponse("Error: Access Token not found!");
  //     }

  //     return false;
  //   } catch (e) {
  //     AppPrint.appError(e.toString(), title: "Email Verify");
  //   }
  //   return false;
  // }

  // Future<dynamic> phoneVerify({required String phone, required String otp}) async {
  //   Map<String, dynamic> body = {"phone": phone, "oneTimeCode": otp};
  //   try {
  //     var response = await nonAuthApi.sendRequest.post(AppApiEndPoint.instance.phoneVerify, data: body);

  //     if (response.statusCode == 200 && response.data != null) {
  //       String accessToken = response.data["data"]["accessToken"];
  //       storageServices.setToken(accessToken);
  //       AppPrint.apiResponse(storageServices.getToken(), title: "Store Token");
  //       return response.data;
  //     } else {
  //       return false;
  //     }
  //     // if (response != null && response.data != null) {
  //     //   String accessToken = response.data["data"]["accessToken"];
  //     //   storageServices.setToken(accessToken);
  //     //   AppPrint.apiResponse(storageServices.getToken(), title: "Store Token");
  //     //   if (response.data["data"]["isFullfilled"] == true) {
  //     //     Get.offAllNamed(AppRoutes.instance.navigationScreen);
  //     //   } else {
  //     //     Get.offAllNamed(AppRoutes.instance.selectBirthScreen);
  //     //   }
  //     //   return true;
  //     // } else {
  //     //   // Handle the error if the response or data is null
  //     //   AppPrint.apiResponse("Error: Access Token not found!");
  //     // }
  //   } catch (e) {
  //     AppPrint.appError(e.toString(), title: "Email Verify");
  //   }
  //   return false;
  // }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      appInPutUnfocused();
      Map body = {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      };
      var response = await ApiServices.instance.apiPostServices(
        url: AppApiEndPoint.instance.changePassword,
        body: body,
      );
      if (response != null) {
        AppPrint.appLog("confirm password repository response :: $response");
        return true;
      }
      return false;
    } on DioException catch (error) {
      if (error.response?.data["message"].runtimeType != Null) {
        Get.snackbar(
          "Error",
          "${error.response?.data["message"] ?? "Something was wrong"}",
        );
      }
      return false;
    } catch (e) {
      errorLog("resetPassword", e);
      return false;
    }
  }

  Future<bool> resetPassword({required String newPassword, required String confirmPassword, required String resetToken}) async {
    try {
      appInPutUnfocused();
      Map body = {"newPassword": newPassword, "confirmPassword": confirmPassword};
      var response = await nonAuthApi.sendRequest.post(
        AppApiEndPoint.instance.resetPassword,
        data: body,
        options: Options(
          receiveTimeout: const Duration(minutes: 2),
          sendTimeout: const Duration(minutes: 2),
          headers: {"Accept": "application/json", "resetToken": resetToken},
        ),
      );

      if (response.statusCode == 200) {
        AppPrint.appLog("confirm password repository response :: $response");
        return true;
      }
      return false;
    } on DioException catch (error) {
      if (error.response?.data["message"].runtimeType != Null) {
        Get.snackbar("Error", "${error.response?.data["message"] ?? "Something was wrong"}");
      }
      return false;
    } catch (e) {
      errorLog("resetPassword", e);
      return false;
    }
  }

  // Future<bool> phoneLogin({required String phone}) async {
  //   try {
  //     Map<String, String> phoneData = {"phone": phone};

  //     var response = await ApiServices.instance.apiPostServices(url: AppApiEndPoint.instance.phoneLogin, body: phoneData);
  //     if (response != null) {
  //       return true;
  //     } else {
  //       AppPrint.appError("phoneLogin");
  //     }
  //     return false;
  //   } catch (e) {
  //     AppPrint.appError(e, title: "phoneLogin");

  //     return false;
  //   }
  // }
}
