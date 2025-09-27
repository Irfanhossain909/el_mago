import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/retailer_order/retailer_order_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';

class RetailerOrderRepository {
  final ApiServices _apiServices = ApiServices.instance;

  // Fetches a paginated list of orders for the retailer
  Future<Map<String, dynamic>> getRetailerOrders({int page = 1}) async {
    try {
      final endpoint = AppApiEndPoint.instance.getMyOrdersRetailer;
      final response = await _apiServices.apiGetServices(
        endpoint,
        queryParameters: {'page': page, 'limit': 10},
      );

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final List<dynamic> orderData = response['data'];
        final pagination = response['pagination'];

        // Determine if there are more pages
        final bool hasMore = pagination['page'] < pagination['totalPage'];

        return {
          'orders': orderData
              .map((json) => RetailerOrderModel.fromJson(json))
              .toList(),
          'hasMore': hasMore,
        };
      } else {
        errorLog('Failed to fetch retailer orders or data is null', '');
        return {'orders': [], 'hasMore': false};
      }
    } catch (e) {
      errorLog('Exception in getRetailerOrders', e.toString());
      return {'orders': [], 'hasMore': false};
    }
  }

  // Fetches the details for a single order
  Future<RetailerOrderModel?> getSingleRetailerOrder(String orderId) async {
    try {
      final endpoint = AppApiEndPoint.getSingleRetailerOrder(orderId);
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        return RetailerOrderModel.fromJson(response['data']);
      } else {
        errorLog('Failed to fetch single retailer order or data is null', '');
        return null;
      }
    } catch (e) {
      errorLog('Exception in getSingleRetailerOrder', e.toString());
      return null;
    }
  }
}
