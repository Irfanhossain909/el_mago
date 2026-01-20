import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';

class OrderRepository {
  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _appApiEndPoint = AppApiEndPoint.instance;

  Future<bool> createOrder({required Map<String, dynamic> body}) async {
    try {
      final response = await _apiServices.apiPostServices(
        url: _appApiEndPoint.createOrder,
        body: body,
      );

      if (response != null && response['success'] == true) {
        AppPrint.appLog("✅ Order placed successfully");
        return true;
      } else {
        AppPrint.appLog("❌ Order placement failed: Response is null or not successful");
        return false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "createOrder");
      return false;
    }
  }
}
