import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/notification_model/notification_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';

class NotificationRepository {
  NotificationRepository._();
  static final NotificationRepository instance = NotificationRepository._();
  ApiServices apiServices = ApiServices.instance;

  Future<List<Result>> getAllNotifications({
    required int page,
    required int limit,
  }) async {
    List<Result> notificationData = <Result>[];
    try {
      // Example: calling API
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.getNotification(page, limit),
      );

      if (response != null && response["data"] != null) {
        if (response["data"]["result"] != null &&
            response["data"]["result"] is List) {
          for (var item in response["data"]["result"]) {
            notificationData.add(Result.fromJson(item));
          }
        }
      } else {
        AppPrint.appError("getAllNotifications");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getAllNotifications");
    }
    return notificationData;
  }
}
