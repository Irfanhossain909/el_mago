import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final SalesDashboardRepository _repository = SalesDashboardRepository();

  var masterProductList = <ProductModel>[].obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var page = 1;

  @override
  void onInit() {
    super.onInit();
    fetchProductsIfEmpty();
  }

  Future<void> fetchProductsIfEmpty() async {
    if (masterProductList.isEmpty) {
      await fetchProducts();
    }
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      page = 1; // Reset page
      hasMore.value = true; // Reset hasMore
      var result = await _repository.getProductsPaginated(page: page);

      final List<ProductModel> products = List<ProductModel>.from(
        result['products'],
      );
      masterProductList.assignAll(products);
      hasMore.value = result['hasMore'];
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoadingMore.value = true;
      page++;
      var result = await _repository.getProductsPaginated(page: page);

      final List<ProductModel> products = List<ProductModel>.from(
        result['products'],
      );
      masterProductList.addAll(products);
      hasMore.value = result['hasMore'];
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }
}
