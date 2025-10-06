import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/retailer_model/retailer_dashboard_summary_model.dart';
import 'package:el_mago/screens/controller/global_controller.dart';
import 'package:el_mago/screens/profile_screen/controller/profile_controller.dart';
import 'package:el_mago/services/api/get_storage_services.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/services/repository/sales_dashboard_repository.dart';
import 'package:el_mago/services/socket/socket_service.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class RetailerDashBoardController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  var getAllProducts = <ProductModel>[].obs;
  var dashboardSummary = Rx<RetailerDashboardSummaryModel?>(null);
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var page = 1;
  ProfileController profileController = Get.find<ProfileController>();
  SalesDashboardRepository salesDashboardRepository =
      SalesDashboardRepository();
  RetailerOrderRepository retailerOrderRepository = RetailerOrderRepository();

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      page = 1; // Reset page
      hasMore.value = true; // Reset hasMore
      var result = await salesDashboardRepository.getProductsPaginated(
        page: page,
      );

      final List<ProductModel> products = List<ProductModel>.from(
        result['products'],
      );
      getAllProducts.assignAll(products);
      hasMore.value = result['hasMore'];
    } catch (e) {
      AppPrint.appError(e, title: "fetchAllProducts");
      getAllProducts.clear();
      hasMore.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || !hasMore.value) return;

    try {
      isLoadingMore.value = true;
      page++;
      var result = await salesDashboardRepository.getProductsPaginated(
        page: page,
      );

      final List<ProductModel> products = List<ProductModel>.from(
        result['products'],
      );
      getAllProducts.addAll(products);
      hasMore.value = result['hasMore'];
    } catch (e) {
      AppPrint.appError(e, title: "loadMoreProducts");
      hasMore.value = false;
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> fetchDashboardSummary() async {
    try {
      var response = await retailerOrderRepository
          .getRetailerDashboardSummary();
      if (response != null) {
        dashboardSummary.value = response;
        AppPrint.appPrint(
          "Dashboard Summary - Total Purchase Amount: ${response.totalPurchaseAmount}",
        );
        AppPrint.appPrint(
          "Dashboard Summary - Total Order Complete: ${response.totalOrderCompleate}",
        );
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchDashboardSummary");
    }
  }

  Future<void> refreshAllData() async {
    try {
      await Future.wait([fetchAllProducts(), fetchDashboardSummary()]);
    } catch (e) {
      AppPrint.appError(e, title: "refreshAllData");
    }
  }

  RxInt count = 0.obs;
  listenMessage(String chatId) async {
    SocketServices.on('new-message::$chatId', (data) {
      count++;

      AppPrint.appPrint(data, title: "Notification");
      // update();

      // var time = data['createdAt'].toLocal();

      // update();
    });
  }

  /////////////////////////////notification////////
  RxInt notificationCount = 0.obs;
  void readSocketMessage() async {
    var uid = getStorageServices.getUID();
    SocketServices.on("notification::$uid", (data) {
      notificationCount.value++;
      AppPrint.appLog("Received notification data: $data");
    });
  }

  /////////////////////////////////////////////
  GetStorageServices getStorageServices = GetStorageServices.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    fetchDashboardSummary();
    AppPrint.appPrint(
      "notification::${getStorageServices.getUID()}",
      title: "SOCket...............................",
    );
    readSocketMessage();
    // getAllProducts.assignAll(globalController.masterProductList);
    // print(
    //   "globalController.masterProductList: ${globalController.masterProductList}",
    // );
    // print("getAllProducts: $getAllProducts");
  }
}
