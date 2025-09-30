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

  // String getStatus({
  //   required int target,
  //   required int totalSpend,
  //   required int current,
  // }) {
  //   // 1️⃣ totalSpend < target হলে locked
  //   if (totalSpend < target) {
  //     return "locked";
  //   }

  //   // 2️⃣ target > totalSpend হলে running
  //   if (target > totalSpend) {
  //     return "Running";
  //   }

  //   // 3️⃣ target <= totalSpend হলে available
  //   if (target <= totalSpend) {
  //     return "Available";
  //   }

  //   // fallback
  //   return "unknown";
  // }

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

  // double calculatePercentage({double? current, double? target}) {
  //   // যদি target পাওয়া যায় এবং target > 0 হয়
  //   if (target != null && target > 0) {
  //     return (current! / target) * 100;
  //   }
  //   // যদি target null হয় কিন্তু totalSpent পাওয়া যায়
  //   else if (loyeltyModelData.value?.loyalty?.totalSpent != null) {
  //     double totalSpent = loyeltyModelData.value!.loyalty!.totalSpent!
  //         .toDouble();
  //     if (totalSpent > 0) {
  //       return (current! / totalSpent) * 100;
  //     }
  //   }

  //   // fallback value
  //   return 0;
  // }

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
