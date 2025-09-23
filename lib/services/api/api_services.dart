import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/api/api.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/services/api/non_auth_api.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:get/get.dart';

class ApiServices {
  ///////////////
  ApiServices._privateConstructor();
  static final ApiServices _instance = ApiServices._privateConstructor();
  static ApiServices get instance => _instance;
  //////////  object
  final api = NonAuthApi();
  final apiAuth = AppApi.instance;
  var storageServices = GetStorageServices.instance;
  Future<dynamic> apiPutServices({
    required String url,
    dynamic body,
    int statusCode = 200,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await apiAuth.sendRequest.put(
        url,
        data: body,
        queryParameters: query,
      );
      if (response.statusCode == statusCode) {
        return response.data;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      Get.snackbar("error", "Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        Get.snackbar("error", "Dio Acception Throw");
        // if (e.response?.statusCode == 401) {
        //   await storageServices.storageClear();
        //   Get.offAllNamed(AppRoutes.signIn);
        // }

        // if (e.response?.data["message"].runtimeType != Null) {
        //   AppSnackBar.error("${e.response?.data["message"]}");
        // }

        // return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }

  Future<dynamic> apiPostServices({
    required String url,
    dynamic body,
    int statusCodeStart = 200,
    int statusCodeEnd = 299,
    Map<String, dynamic>? query,
  }) async {
    try {
      // final dynamic response = await api.sendRequest.post(url, data: body);
      final dynamic response = await apiAuth.sendRequest.post(
        url,
        data: body,
        queryParameters: query,
      );
      if (response.statusCode >= statusCodeStart &&
          response.statusCode <= statusCodeEnd) {
        return response.data;
      } else {
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      Get.snackbar("error", "Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.instance.signinScreen);
        }

        if (e.response?.data["message"].runtimeType != Null) {
          Get.snackbar("error", "${e.response?.data["message"]}");
        }

        return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }

  Future<dynamic> apiGetServices(
    String url, {
    int statusCode = 200,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    try {
      final response = await AppApi.instance.sendRequest.get(
        url,
        queryParameters: queryParameters,
        data: body,
      );

      if (response.statusCode == statusCode) {
        // এখানে চেক করছি যে, response.data ম্যাপ কি লিস্ট
        if (response.data is Map<String, dynamic>) {
          return response.data; // ম্যাপ থাকলে ম্যাপ রিটার্ন
        } else if (response.data is List) {
          return response.data; // লিস্ট থাকলে লিস্ট রিটার্ন
        } else {
          return response
              .data; // যদি কিছু অন্য ধরনের ডেটা আসে, তাহলে সোজা সেই ডেটা রিটার্ন
        }
      } else {
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      Get.snackbar("error", "আপনার ইন্টারনেট সংযোগ চেক করুন");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.instance.signinScreen);
        }

        if (e.response?.data["message"] != null) {
          Get.snackbar("error", "${e.response?.data["message"]}");
        }
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }

  Future<dynamic> apiPatchServices({
    required String url,
    Object? body,
    int statusCode = 200,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    try {
      final response = await apiAuth.sendRequest.patch(
        url,
        data: body,
        queryParameters: query,
        options: options,
      );

      if (response.statusCode == statusCode) {
        return response.data;
      } else {
        Get.snackbar(
          "error",
          "Unexpected response: ${response.statusCode} ${response.statusMessage}"
              "Unexpected response: ${response.statusCode} ${response.statusMessage}",
        );
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      Get.snackbar("error", "Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.instance.signinScreen);
        }

        if (e.response?.data["message"].runtimeType != Null) {
          Get.snackbar("error", "${e.response?.data["message"]}");
        }

        return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }

  Future<dynamic> apiDeleteServices({
    required String url,
    Object? body,
    int statusCode = 200,
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    try {
      final response = await apiAuth.sendRequest.delete(
        url,
        data: body,
        queryParameters: query,
        options: options,
      );

      if (response.statusCode == statusCode) {
        return response.data;
      } else {
        Get.snackbar(
          "error",
          "Unexpected response: ${response.statusCode} ${response.statusMessage}",
        );
        return null;
      }
    } on SocketException catch (e) {
      errorLog('api socket exception', e);
      Get.snackbar("error", "Check Your Internet Connection");
      return null;
    } on TimeoutException catch (e) {
      errorLog('api time out exception', e);
      return null;
    } on DioException catch (e) {
      if (e.response.runtimeType != Null) {
        if (e.response?.statusCode == 401) {
          await storageServices.storageClear();
          Get.offAllNamed(AppRoutes.instance.signinScreen);
        }

        if (e.response?.data["message"].runtimeType != Null) {
          Get.snackbar("error", "${e.response?.data["message"]}");
        }

        return null;
      }
      errorLog('api dio exception', e);
      return null;
    } catch (e) {
      errorLog('api exception', e);
      return null;
    }
  }
}
