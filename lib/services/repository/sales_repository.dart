import 'package:el_mago/const/app_api_end_point.dart';
import 'package:el_mago/models/retailer_model/retailer_model.dart';
import 'package:el_mago/models/sales_model/sales_model.dart';
import 'package:el_mago/services/api/api_services.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';

class SalesRepository {
  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _appApiEndPoint = AppApiEndPoint.instance;

  Future<List<RetailerModel>> getMyRetailers() async {
    try {
      final endpoint = _appApiEndPoint.getMyRetailers;
      final response = await _apiServices.apiGetServices(endpoint);

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        final List<dynamic> retailerData = response['data'];
        return retailerData
            .map((json) => RetailerModel.fromJson(json))
            .toList();
      } else {
        errorLog('Failed to fetch retailers or data is null', '');
        return []; // Return an empty list on failure
      }
    } catch (e) {
      errorLog('Exception in getMyRetailers', e.toString());
      return []; // Return an empty list on error
    }
  }

  Future<SalesModel?> getMySales(List<String> years) async {
    try {
      final endpoint = _appApiEndPoint.getMySales;
      final queryParameters = {'years': years.join(',')};

      final response = await _apiServices.apiGetServices(
        endpoint,
        queryParameters: queryParameters,
      );

      if (response != null && response['success'] == true) {
        return SalesModel.fromJson(response);
      } else {
        errorLog(
          'Failed to fetch sales data or data is null',
          response.toString(),
        );
        return null;
      }
    } catch (e) {
      errorLog('Exception in getMySales', e.toString());
      return null;
    }
  }
}
