import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/models/order_model/extra_box_request_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';

class SalesDashboardRepository {
  final ApiServices _apiServices = ApiServices.instance;

  Future<List<ProductModel>> getProducts() async {
    try {
      final endpoint = AppApiEndPoint.instance.getProducts;
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final List<dynamic> productData = response['data'];
        return productData.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        errorLog('Failed to fetch products or data is null', '');
        return [];
      }
    } catch (e) {
      errorLog('Exception in getProducts', e.toString());
      return [];
    }
  }

  /// Place an order for extra boxes
  Future<Map<String, dynamic>?> placeExtraBoxOrder(
    String userId,
    ExtraBoxRequest extraBoxRequest,
  ) async {
    try {
      final endpoint = AppApiEndPoint.updateExtraBoxes(userId);
      final response = await _apiServices.apiPostServices(
        url: endpoint,
        body: extraBoxRequest.toJson(),
      );

      if (response != null && response['success'] == true) {
        return response;
      } else {
        errorLog('Failed to place extra box order', response.toString());
        return null;
      }
    } catch (e) {
      errorLog('Exception in placeExtraBoxOrder', e.toString());
      return null;
    }
  }
}
