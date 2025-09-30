import 'package:el_mago/screens/sales_retailer_information_screnn/controller/sales_retailer_info_controller.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesEditNewRetailasController extends GetxController {
  //repository
  RetailerOrderRepository retailerOrderRepository = RetailerOrderRepository();

  //controllers
  // SalesRetailerManagementController salesRetailerManagementController =
  //     Get.find();
  SalesRetailerInfoController salesRetailerInfoController = Get.find();

  //variables
  String? retailerId;
  RxBool isLoading = false.obs;

  //textController
  TextEditingController retailerNameController = TextEditingController();
  TextEditingController retailerPhoneController = TextEditingController();
  TextEditingController retailerAddressController = TextEditingController();
  TextEditingController retailerEmailController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvcController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  //validation
  bool isValidation() {
    if (retailerNameController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    } else if (retailerPhoneController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    } else if (retailerAddressController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    } else if (retailerEmailController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
    } else if (cardNameController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    } else if (cardNumberController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    } else if (expiryController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    } else if (cvcController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    } else if (zipController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    }

    return true;
  }

  // functions
  Future<void> updateRetailer() async {

    try {
       bool isValid = isValidation();
      if (!isValid) return;
      isLoading.value = true;
      var response = await retailerOrderRepository.updateRetailer(
        retailerId: retailerId ?? "",
        name: retailerNameController.text,
        phone: retailerPhoneController.text,
        address: retailerAddressController.text,
        cardHolderName: cardNameController.text,
        cardNumber: cardNumberController.text,
        expiryDate: expiryController.text,
        cvv: cvcController.text,
        zipCode: zipController.text,
      );
      if (response) {
        Get.snackbar("Success", "Update Retailer Successfully");

        Get.close(1);

        isLoading.value = false;
        // G
      } else {
        AppPrint.appError("add is False");
        isLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "Add Retailer");
    } finally {
      isLoading.value = false;
    }
  }

  void disposeController() {
    retailerNameController.dispose();
    retailerPhoneController.dispose();
    retailerAddressController.dispose();
    retailerEmailController.dispose();
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    zipController.dispose();
  }

 

  void controllerInisialiezed() {
    retailerNameController = TextEditingController();
    retailerPhoneController = TextEditingController();
    retailerAddressController = TextEditingController();
    retailerEmailController = TextEditingController();
    cardNameController = TextEditingController();
    cardNumberController = TextEditingController();
    expiryController = TextEditingController();
    cvcController = TextEditingController();
    zipController = TextEditingController();
  }

  @override
  void onInit() {
    retailerId = Get.arguments;
    AppPrint.appLog("Retailer Id: $retailerId");
    controllerInisialiezed();
    super.onInit();
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }
}
