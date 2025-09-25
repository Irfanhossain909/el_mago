
import 'package:el_mago/models/product_model/product_model.dart';
import 'package:el_mago/screens/controller/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesDashboardController extends GetxController {
  // Get the instance of the global controller
  final GlobalController globalController = Get.find<GlobalController>();

  final searchController = TextEditingController();
  var filteredProductList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the filtered list with the master list from the global controller
    filteredProductList.assignAll(globalController.masterProductList);

    // Listen for changes in the master list and update the filtered list
    ever(globalController.masterProductList, (masterList) {
      filteredProductList.assignAll(masterList);
      // Also apply current search filter if any
      filterProducts(searchController.text);
    });

    // Add a listener to the search field to filter results
    searchController.addListener(() {
      filterProducts(searchController.text);
    });
  }

  void filterProducts(String productName) {
    if (productName.isEmpty) {
      // If search is empty, show all products from the master list
      filteredProductList.assignAll(globalController.masterProductList);
    } else {
      // Filter the master list based on the search query
      var filteredList = globalController.masterProductList
          .where((product) =>
              product.name.toLowerCase().contains(productName.toLowerCase()))
          .toList();
      filteredProductList.assignAll(filteredList);
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
