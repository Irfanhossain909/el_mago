import 'package:get/get.dart';
import '../../../services/repository/common_repository.dart';
import '../../../widgets/app_log/error_log.dart';

class TermsAndConditionsController extends GetxController {
  final CommonRepository commonRepository = CommonRepository();
  // final args = Get.arguments;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  String? tarms;
  String? value;

  @override
  void onInit() {
    value = Get.arguments['value'];
    super.onInit();
    loadData();
  }

  void loadData() async {
    try {
      isLoading(true);
      errorMessage('');

      final response = await commonRepository.fetchDisclaimerData(
        value: value ?? "",
      );
      if (response != null) {
        tarms = response;
        errorMessage('');
      } else {
        errorMessage('No content available');
      }
    } catch (e, st) {
      errorLog('loadData', "$e\n$st");
      errorMessage('Error loading content: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // Method to reload data
  void refreshData() {
    loadData();
  }
}
