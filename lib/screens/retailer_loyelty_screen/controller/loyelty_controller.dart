import 'package:el_mago/models/loyelty_model/loyelty_model.dart';
import 'package:el_mago/services/repository/loyelty_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class LoyeltyController extends GetxController {
  Rxn<LoyeltyModelData> loyeltyModelData = Rxn<LoyeltyModelData>();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  LoyeltyRepository loyeltyRepository = LoyeltyRepository.instance;

  String getStatus({
    required int target,
    required int totalSpend,
    required int current,
  }) {
    // target > totalSpend হলে Running
    if (target > totalSpend) {
      return "Running";
    }

    // target <= totalSpend হলে Available
    return "Available";
  }


  int calculatePercentage({double? current, double? target}) {
    double percentage = 0;

    if (target != null && target > 0) {
      percentage = (current ?? 0) / target * 100;
    } else if (loyeltyModelData.value?.loyalty?.totalSpent != null) {
      double totalSpent = loyeltyModelData.value!.loyalty!.totalSpent!
          .toDouble();
      if (totalSpent > 0) {
        percentage = (current ?? 0) / totalSpent * 100;
      }
    }

    // ensure no decimal and max 100
    return percentage.clamp(0, 100).toInt();
  }

  Future<void> getLoyeltyModelData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      AppPrint.appLog("🔄 Starting loyalty data fetch...");

      var response = await loyeltyRepository.getLoyeltyData();
      if (response != null) {
        loyeltyModelData.value = response;
        AppPrint.appLog("✅ Loyalty data fetched successfully");
        AppPrint.appLog("📊 Total Spent: ${response.loyalty?.totalSpent}");
        AppPrint.appLog(
          "📊 Total Spent Model: ${loyeltyModelData.value?.loyalty?.totalSpent}",
        );
        AppPrint.appLog(
          "🎁 Available Rewards: ${response.availableRewards?.length}",
        );
      } else {
        errorMessage.value = 'Failed to fetch loyalty data';
        AppPrint.appError("❌ Loyalty data response is null");
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      AppPrint.appError(e, title: "LoyeltyController.getLoyeltyModelData");
    } finally {
      isLoading.value = false;
      update(); // Trigger UI rebuild for GetBuilder widgets
    }
  }

  @override
  void onInit() {
    super.onInit();
    getLoyeltyModelData();
  }
}
