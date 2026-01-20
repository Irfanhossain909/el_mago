import 'package:el_mago/models/order_model/order_model.dart';
import 'package:el_mago/screens/sales_my_order/controller/sales_my_order_controller.dart';
import 'package:get/get.dart';

class SalesOrderDetailsController extends GetxController {
  // Find the parent controller to get the selected order
  final SalesMyOrderController _myOrderController = Get.find<SalesMyOrderController>();

  // Observable to hold the order details for the UI
  var order = Rx<OrderModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get the selected order from the SalesMyOrderController
    order.value = _myOrderController.selectedOrder.value;
  }
}
