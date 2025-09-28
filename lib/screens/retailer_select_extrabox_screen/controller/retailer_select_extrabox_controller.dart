import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/retailer_model/retailer_dashboard_summary_model.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class RetailerSelectExtraboxController extends GetxController {
  var getAllProducts = <ProductModel>[].obs;
  var dashboardSummary = Rx<RetailerDashboardSummaryModel?>(null);
  var isLoading = false.obs;

  SalesDashboardRepository salesDashboardRepository =
      SalesDashboardRepository();

  Future<void> fetchAllProducts() async {
    try {
      var response = await salesDashboardRepository.getProducts();
      if (response.isNotEmpty) {
        getAllProducts.assignAll(response);
        AppPrint.appPrint("getAllProducts Id: ${getAllProducts.first.id}");
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchAllProducts");
    }
  }

  @override
  void onInit() {
    fetchAllProducts();
    super.onInit();
  }
}
