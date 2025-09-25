import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final SalesDashboardRepository _repository = SalesDashboardRepository();

  var masterProductList = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductsIfEmpty();
  }

  Future<void> fetchProductsIfEmpty() async {
    if (masterProductList.isEmpty) {
      try {
        isLoading(true);
        var products = await _repository.getProducts();
        masterProductList.assignAll(products);
      } finally {
        isLoading(false);
      }
    }
  }
}
