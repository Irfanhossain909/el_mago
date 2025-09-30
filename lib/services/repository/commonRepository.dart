import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/legal_document_model/legal_document_model.dart';
import '../api/api_services.dart';

class CommonRepository {

  final ApiServices apiServices = ApiServices.instance;


  Future<TermsAndConditionsResponse?> fetchDisclaimerData({required String url}) async {
    try {
      final response = await apiServices.apiGetServices(url);

      return TermsAndConditionsResponse.fromJson(response);
    } catch (e) {
      Get.snackbar("Error", "Error fetching terms and conditions: ${e.toString()}");

      return null;
    }
  }


}