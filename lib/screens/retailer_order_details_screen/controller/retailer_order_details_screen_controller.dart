import 'package:el_mago/models/retailer_order/retailer_order_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
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
      print('No order ID provided');
      isLoading(false);
    }
  }

  void fetchOrderDetails(String orderId) async {
    try {
      isLoading(true);
      print('Fetching order details for ID: $orderId');
      final orderData = await _repository.getSingleRetailerOrder(orderId);
      if (orderData != null) {
        order.value = orderData;
        print('Order details fetched successfully: ${orderData.orderId}');
      } else {
        print('No order data received');
      }
    } catch (e) {
      print('Error fetching order details: $e');
    } finally {
      isLoading(false);
    }
  }
}
