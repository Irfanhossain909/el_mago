import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/loyelty_model/loyelty_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';

class LoyeltyRepository {
  LoyeltyRepository._();
  static final LoyeltyRepository instance = LoyeltyRepository._();
  ApiServices apiServices = ApiServices.instance;
  Future<LoyeltyModelData?> getLoyeltyData() async {
    try {
      AppPrint.appLog(
        "🔍 Making loyalty API call to: ${AppApiEndPoint.instance.loyelty}",
      );

      var response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.loyelty,
      );

      AppPrint.appLog("📝 API Response: $response");

      if (response != null) {
        // Check if response has the expected structure
        if (response is Map<String, dynamic>) {
          if (response['success'] == true && response['data'] != null) {
            // Parse the full model first, then extract data
            LoyeltyModel fullModel = LoyeltyModel.fromJson(response);
            AppPrint.appLog("✅ Loyalty model parsed successfully");
            return fullModel.data;
          } else {
            AppPrint.appError(
              "API returned success=false or null data: ${response['message'] ?? 'Unknown error'}",
            );
            return null;
          }
        } else {
          AppPrint.appError(
            "Unexpected response format: ${response.runtimeType}",
          );
          return null;
        }
      } else {
        AppPrint.appError(
          "LoyeltyRepository.getLoyeltyData - Response is null",
          title: "Error",
        );
        return null;
      }
    } catch (e) {
      AppPrint.appError(e, title: "LoyeltyRepository.getLoyeltyData");
      return null;
    }
  }

  Future<bool> redeemLoyelty({required String retailerId}) async {
    var url = "${AppApiEndPoint.instance.redeemProducts}/$retailerId";
    try {
      var response = await apiServices.apiPostServices(url: url);
      if (response != null) {
        // Check if response is a Map and has success field
        if (response is Map<String, dynamic>) {
          // Look for success field in the response
          if (response['success'] == true) {
            return true;
          } else {
            AppPrint.appError(
              "Redeem failed: ${response['message'] ?? 'Unknown error'}",
            );
            return false;
          }
        } else {
          AppPrint.appError(
            "Unexpected response format: ${response.runtimeType}",
          );
          return false;
        }
      } else {
        AppPrint.appError("Response is null");
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "redeemLoyelty");
    }
    return false;
  }
}
