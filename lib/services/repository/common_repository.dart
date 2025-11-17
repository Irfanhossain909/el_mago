import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';
import '../api/api_services.dart';

class CommonRepository {
  final ApiServices apiServices = ApiServices.instance;

  Future<dynamic> fetchDisclaimerData({required String value}) async {
    try {
      final response = await apiServices.apiGetServices(
        "${AppApiEndPoint.instance.termsAndConditions}$value",
      );

      if (response != null && response["data"] != null) {
        return response["data"];
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error fetching terms and conditions: ${e.toString()}",
      );

      return null;
    }
  }

  Future<bool> deleteAccount({required String password}) async {
    Map<String, dynamic> body = {"password": password};
    try {
      var response = await apiServices.apiDeleteServices(
        url: AppApiEndPoint.instance.deleteAccount,
        body: body,
      );
      if (response["success"] == true) {
        return true;
      } else {
        Get.snackbar("Error", response["message"]);
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "Error");
    }
    return false;
  }
}
