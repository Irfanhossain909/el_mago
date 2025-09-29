import 'package:el_mago/models/retailer_order/all_retailer_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class SalesRetailerManagementController extends GetxController {
  //repository
  RetailerOrderRepository repository = RetailerOrderRepository();


  //variables
  RxList<AlLRetailerModelData> retailerOrderList = <AlLRetailerModelData>[].obs;
  var isLoading = false.obs;

  Future<void> fetchRetailerData() async {
    try {
      isLoading.value = true;
      var response = await repository.getAllRetailers();
      if (response.isNotEmpty) {
        retailerOrderList.assignAll(response);
      } else {
        AppPrint.appError("fetchRetailerData - No data found");
        // retailerOrderList = []; // Ensure list is empty when no data
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchRetailerData");
      // retailerOrderList = []; // Ensure list is empty on error
    } finally {
      isLoading.value = false;
      update(); // Notify GetBuilder to rebuild
    }
  }

  Future<void> deleteRetailer({required String retailerId}) async {
    try {
      var response = await repository.deleteRetailer(
        retailerId: retailerId,
      );
      if (response) {
        Get.snackbar("Success", "Retailer deleted successfully");
        await fetchRetailerData();
      } else {
        AppPrint.appError("deleteRetailer - No data found");
        // retailerOrderList = []; // Ensure list is empty when no data
      }
    } catch (e) {
      AppPrint.appError(e, title: "deleteRetailer");
    }
  }

  @override
  void onInit() {
    fetchRetailerData();
    super.onInit();
  }
}
