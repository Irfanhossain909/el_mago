

import 'package:el_mago/models/retailer_order/retailer_analitics.dart';
import 'package:el_mago/models/retailer_order/retailer_details_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class SalesRepresentativeDetailsController extends GetxController {
  //repository
  RetailerOrderRepository repository = RetailerOrderRepository();

  //variables
  String? retailerId;
  Rxn<RetailerDetailsDataModel> retailerModel = Rxn();
  Rxn<RetailerAnaliticsData> retailerAnaliticsModel = Rxn();
  var isLoading = false.obs;

  Future<void> fetchRetailerData() async {
    try {
      isLoading.value = true;
      var response = await repository.getSingleRetailer(
        retailerId: retailerId ?? "",
      );
      if (response != null) {
        retailerModel.value = response;
        isLoading.value = false;
      } else {
        AppPrint.appError("Response is null");
        isLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchRetailerData");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRetailerAnalatics({required String retailerId}) async {
    try {
      isLoading.value = true;
      var response = await repository.getSingleUserAnalatics(
        retailerId: retailerId,
      );
      if (response != null) {
        retailerAnaliticsModel.value = response;
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchRetailerAnalatics");
    } finally {
      isLoading.value = false; // লোডিং বন্ধ করা উচিত
    }
  }

  @override
  void onInit() {
    fetchRetailerData();
    retailerId = Get.arguments;
    super.onInit();
  }
}
