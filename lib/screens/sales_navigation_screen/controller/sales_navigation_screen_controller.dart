import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesNavigationScreenController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  bool isExpanded = false;
  RxBool isHomeDataLoad = false.obs;
  int page = 1;
  int notificationPage = 1;
  RxBool isLastPage = false.obs;

  final ScrollController scrollController = ScrollController();

  // final GetStorageServices getStorageServices = GetStorageServices.instance;

  void toggleExpansion() {
    isExpanded = !isExpanded;
    update(); // Notifies GetBuilder to rebuild
  }

  changeIndex(int index) {
    selectedIndex.value = index;
  }
}
