import 'package:el_mago/services/repository/sales_my_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/state_manager.dart';

class SalesCommitionBreackdownController extends GetxController {
  MyOrderRepository myOrderRepository = MyOrderRepository();

  RxString salesCommitionBreackdown = ''.obs;

  RxBool isLoading = true.obs;

  Future<void> fetchMyOrderTotalEarnings() async {
    try {
      isLoading.value = true;
      var response = await myOrderRepository.getTotalEarnCommision();
      if (response != null) {
        salesCommitionBreackdown.value = response.toString();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchMyOrderTotalEarnings");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchMyOrderTotalEarnings();
    super.onInit();
  }
}
