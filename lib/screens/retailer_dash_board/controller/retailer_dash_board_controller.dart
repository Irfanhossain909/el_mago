import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/screens/controller/global_controller.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class RetailerDashBoardController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  var getAllProducts = <ProductModel>[].obs;

  SalesDashboardRepository salesDashboardRepository =
      SalesDashboardRepository();

  Future<void> fetchAllProducts() async {
    try {
      var response = await salesDashboardRepository.getProducts();
      if (response.isNotEmpty) {
        getAllProducts.assignAll(response);
        print("getAllProducts Id: ${getAllProducts.first.id}");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchAllProducts");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    // getAllProducts.assignAll(globalController.masterProductList);
    // print(
    //   "globalController.masterProductList: ${globalController.masterProductList}",
    // );
    // print("getAllProducts: $getAllProducts");
  }
}
