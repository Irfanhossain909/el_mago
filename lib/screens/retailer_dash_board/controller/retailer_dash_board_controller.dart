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
  ProfileController profileController = Get.find<ProfileController>();
  SalesDashboardRepository salesDashboardRepository =
      SalesDashboardRepository();
  RetailerOrderRepository retailerOrderRepository = RetailerOrderRepository();

  Future<void> fetchAllProducts() async {
    try {
      var response = await salesDashboardRepository.getProducts();
      if (response.isNotEmpty) {
        getAllProducts.assignAll(response);
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchAllProducts");
    }
  }

  Future<void> fetchDashboardSummary() async {
    try {
      var response = await retailerOrderRepository
          .getRetailerDashboardSummary();
      if (response != null) {
        dashboardSummary.value = response;
        print(
          "Dashboard Summary - Total Purchase Amount: ${response.totalPurchaseAmount}",
        );
        print(
          "Dashboard Summary - Total Order Complete: ${response.totalOrderCompleate}",
        );
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchDashboardSummary");
    }
  }

  Future<void> refreshAllData() async {
    try {
      isLoading.value = true;
      await Future.wait([fetchAllProducts(), fetchDashboardSummary()]);
    } catch (e) {
      AppPrint.appError(e, title: "refreshAllData");
    } finally {
      isLoading.value = false;
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
