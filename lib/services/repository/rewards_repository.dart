import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/reward_model/reward_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';

class RewardsRepository {
  final ApiServices apiServices = ApiServices.instance;

  Future<List<UserRewardModel>?> getMyRewards() async {
    try {
      var response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.getMyRewards,
      );

      if (response != null && response["success"] == true) {
        if (response["data"] != null && response["data"] is List) {
          List<dynamic> rewardsData = response["data"];
          return rewardsData
              .map((json) => UserRewardModel.fromJson(json))
              .toList();
        }
      } else {
        AppPrint.appLog("getMyRewards response null or unsuccessful");
        return null;
      }
    } catch (e) {
      AppPrint.appError(e, title: "getMyRewards");
    }
    return null;
  }
}
