import 'package:el_mago/models/retailer_order/retailer_order_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class RetailerOrderDetailsController extends GetxController {
  final RetailerOrderRepository _repository = RetailerOrderRepository();

  var order = Rx<RetailerOrderModel?>(null);
  var isLoading = true.obs;
  var orderId = '';

  @override
  void onInit() {
    super.onInit();
    // Get order ID from arguments or route parameters
    if (Get.arguments != null) {
      orderId = Get.arguments as String;
    } else if (Get.parameters['orderId'] != null) {
      orderId = Get.parameters['orderId']!;
    }

    if (orderId.isNotEmpty) {
      fetchOrderDetails(orderId);
    } else {
      AppPrint.appPrint('No order ID provided');
      isLoading(false);
    }
  }

  void fetchOrderDetails(String orderId) async {
    try {
      isLoading(true);
      AppPrint.appPrint('Fetching order details for ID: $orderId');
      final orderData = await _repository.getSingleRetailerOrder(orderId);
      if (orderData != null) {
        order.value = orderData;
        AppPrint.appPrint('Order details fetched successfully: ${orderData.orderId}');
      } else {
        AppPrint.appPrint('No order data received');
      }
    } catch (e) {
      AppPrint.appPrint('Error fetching order details: $e');
    } finally {
      isLoading(false);
    }
  }
}
