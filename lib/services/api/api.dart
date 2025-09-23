
import 'package:dio/dio.dart';
import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/routes/app_routes.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppApi {
  final Dio _dio = Dio();
  var storageServices = GetStorageServices.instance;

  // Private constructor where Dio is configured
  AppApi._privateConstructor() {
    _dio.options.baseUrl = AppApiEndPoint.instance.baseUrl;
    _dio.options.sendTimeout = const Duration(seconds: 120);
    _dio.options.connectTimeout = const Duration(seconds: 120);
    _dio.options.receiveTimeout = const Duration(seconds: 120);
    _dio.options.followRedirects = false;

    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.baseUrl = AppApiEndPoint.instance.baseUrl;
          options.contentType = 'application/json';
          options.headers["Accept"] = "application/json";

          String token = storageServices.getToken();
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onError: (error, handler) async {
          AppPrint.appLog("API error occurred:");
          AppPrint.appLog("Status code: ${error.response?.statusCode}");
          AppPrint.appLog("Error message: ${error.message}");

          try {
            if (error.response?.statusCode == 401) {
              await storageServices.storageClear();
              Get.offAllNamed(AppRoutes.instance.signinScreen);
              return handler.next(error);
            }
          } catch (e) {
            errorLog("error form api try and catch bloc", e);
            return handler.next(error);
          }

          return handler.next(error);
        },
      ),
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          request: true,
          compact: true,
          error: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
    ]);
  }

  // Singleton instance
  static final AppApi _instance = AppApi._privateConstructor();

  // Getter for singleton instance
  static AppApi get instance => _instance;

  // Expose Dio client
  Dio get sendRequest => _dio;
}

