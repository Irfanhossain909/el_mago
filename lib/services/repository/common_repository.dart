import 'package:el_mago/const/app_api_end_point.dart';
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
}
