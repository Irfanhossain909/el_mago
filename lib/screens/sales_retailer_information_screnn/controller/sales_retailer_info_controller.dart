import 'package:el_mago/models/retailer_order/retailer_card_info_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class SalesRetailerInfoController extends GetxController {
  //repository
  RetailerOrderRepository retailerOrderRepository = RetailerOrderRepository();

  //variables
  String? retailerId;
  RxBool isLoading = true.obs;
  Rxn<RetailerCardInfoModelData> retailerCardData =
      Rxn<RetailerCardInfoModelData>();

  //methods
  Future<void> getRetailerCardInfo() async {
    try {
      isLoading.value = true;
      var response = await retailerOrderRepository.getRetailerCardInfo(
        retailerId: retailerId ?? "",
      );
      if (response != null) {
        retailerCardData.value = response;
        isLoading.value = false;
      } else {
        AppPrint.appError("getRetailerCardInfo");
        isLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "getRetailerCardInfo");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    retailerId = Get.arguments;
    getRetailerCardInfo();
    super.onInit();
  }
}
