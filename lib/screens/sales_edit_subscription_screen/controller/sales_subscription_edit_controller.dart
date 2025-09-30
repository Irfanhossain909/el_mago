import 'package:el_mago/models/sub_model/sub_model.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/services/repository/subscription_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SalesSubscriptionEditController extends GetxController {
  SubscriptionRepository subscriptionRepository =
      SubscriptionRepository.instance;
  late TextEditingController tireController;
  RxInt selectedSubType = 0.obs;

  RxList<SubModelData> subTypeList = <SubModelData>[].obs;

  onSelectionChange(int index) {
    selectedSubType.value = index;
    if (selectedSubType < subTypeList.length) {
      tireController.text = subTypeList[selectedSubType.value].tier ?? '';
    }
  }

  Future<void> getSubTypeList() async {
    try {
      var response = await subscriptionRepository.getSubModels();
      if (response.isNotEmpty) {
        subTypeList.addAll(response);
      } else {
        AppPrint.appError("No data found", title: "getSubTypeList");
      }
    } catch (e) {
      AppPrint.appError(e, title: "getSubTypeList");
    }
  }

  addRetailer() async {
    if (selectedSubType >= subTypeList.length) return;
    final model = subTypeList.value[selectedSubType.value];
    if (model.subscription == null || model.tier == null) return;
    final isSuccess = await subscriptionRepository.updateCardInfoPro(
      tier: model.tier,
      subscription: model.subscription,
      retailerId: Get.arguments,
    );

    if (isSuccess) {
      Get.close(1);
    } else {
      AppPrint.appError("Something went wrong", title: "Up");
    }
  }

  @override
  void dispose() {
    tireController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    tireController = TextEditingController();
    getSubTypeList();
    super.onInit();
  }
}
