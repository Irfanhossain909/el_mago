import 'package:el_mago/models/loyelty_model/loyelty_model.dart';
import 'package:el_mago/services/repository/loyelty_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class LoyeltyController extends GetxController {
  Rxn<LoyeltyModelData> loyeltyModelData = Rxn<LoyeltyModelData>();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  LoyeltyRepository loyeltyRepository = LoyeltyRepository.instance;

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
