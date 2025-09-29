// import 'package:get/get.dart';
//
//
// import '../../../widgets/app_log/error_log.dart';
//
// class AboutUsController extends GetxController {
//   // final CommonRepository commonRepository = CommonRepository();
//   // var termsConditions = StaticPageModel().obs;
//   var isLoading = false.obs;
//   var data = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadData();
//   }
//
//   void loadData() async {
//     try {
//       isLoading(true);
//       final response = await commonRepository.fetchAboutUs();
//       if (response != null && response.data != null) {
//         termsConditions.value = response;
//         data.value = (response.data!.content ?? '')
//             .replaceAll('white-space:pre-wrap;', '')
//             .replaceAll('\u00A0', ' ')
//             .replaceAll(RegExp(r'\s+'), ' ')
//             .trim();
//       } else {
//         // AppSnackBar.message("About Us not found");
//       }
//     } catch (e) {
//       errorLog('tearm', e);
//       // AppSnackBar.error(e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }
