import 'package:el_mago/models/retailer_order/retailer_card_info_model.dart';
import 'package:el_mago/screens/sales_retailer_information_screnn/controller/sales_retailer_info_controller.dart';
import 'package:el_mago/screens/sales_shopping_cart/controller/sales_shopping_cart_controller.dart';
import 'package:el_mago/services/repository/retailer_order_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesEditNewRetailasController extends GetxController {
  // Repository
  final RetailerOrderRepository retailerOrderRepository =
      RetailerOrderRepository();

  // Other Controllers
  final SalesShoppingCartController salesShoppingCartController = Get.find();
  final SalesRetailerInfoController salesRetailerInfoController = Get.find();

  // Variables
  String? retailerId;
  RxBool isLoading = false.obs;
  Rxn<RetailerCardInfoModelData> retailerCardData =
      Rxn<RetailerCardInfoModelData>();

  // Text Controllers
  late TextEditingController retailerNameController;
  late TextEditingController retailerPhoneController;
  late TextEditingController retailerAddressController;
  late TextEditingController retailerEmailController;
  late TextEditingController cardNameController;
  late TextEditingController cardNumberController;
  late TextEditingController expiryController;
  late TextEditingController cvcController;
  late TextEditingController zipController;

  // ---------------------------- INITIALIZE ----------------------------

  @override
  void onInit() {
    super.onInit();
    inisial();
  }

  void inisial() async {
    retailerId = Get.arguments;
    controllerInisialiezed();
    await getRetailerCardInfo(); // fetch data
    setRetailerDataToControllers(); // fill text fields with model data
    AppPrint.appLog("Retailer Id: $retailerId");
  }

  // Initialize all controllers
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

  // Dispose all controllers
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

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  // ---------------------------- VALIDATION ----------------------------

  bool isValidation() {
    if (retailerNameController.text.isEmpty ||
        retailerPhoneController.text.isEmpty ||
        retailerAddressController.text.isEmpty ||
        retailerEmailController.text.isEmpty ||
        cardNameController.text.isEmpty ||
        cardNumberController.text.isEmpty ||
        expiryController.text.isEmpty ||
        cvcController.text.isEmpty ||
        zipController.text.isEmpty) {
      Get.snackbar("Required", "Please fill all the fields");
      return false;
    }
    return true;
  }

  // ---------------------------- FETCH DATA ----------------------------

  //methods
  Future<void> getRetailerCardInfo() async {
    try {
      isLoading.value = true;
      update(); // show loader in UI
      var response = await retailerOrderRepository.getRetailerCardInfo(
        retailerId: retailerId ?? "",
      );
      if (response != null) {
        retailerCardData.value = response;
        isLoading.value = false;
      } else {
        AppPrint.appError("getRetailerCardInfo");
        isLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "getRetailerCardInfo");
    } finally {
      isLoading.value = false;
      update(); // hide loader
    }
  }



  // ---------------------------- SET DATA INTO TEXT CONTROLLERS ----------------------------

  void setRetailerDataToControllers() {
    final data = retailerCardData.value;
    if (data == null) return;

    retailerNameController.text = data.retailerInfo?.name ?? '';
    retailerEmailController.text = data.retailerInfo?.email ?? '';
    retailerAddressController.text = data.retailerInfo?.address ?? '';
    retailerPhoneController.text = data.retailerInfo?.phone ?? '';
    // Payment info (if available from API)
    cardNameController.text = data.card?.cardHolderName ?? '';
    cardNumberController.text = data.card?.cardNumber ?? '';
    expiryController.text = data.card?.expiryDate ?? '';
    cvcController.text = data.card?.cvv ?? '';
    zipController.text = data.card?.zipCode ?? '';

    update(); // refresh GetBuilder UI
  }

  // ---------------------------- UPDATE RETAILER ----------------------------

  Future<void> updateRetailer() async {
    try {
      if (!isValidation()) return;

      isLoading.value = true;
      update(); // show loader

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
        Get.snackbar("Success", "Retailer updated successfully!");
        salesShoppingCartController.fetchRetailers();

        await getRetailerCardInfo(); // re-fetch updated data if needed
        Get.close(1);
      } else {
        AppPrint.appError("Update failed");
      }
    } catch (e) {
      AppPrint.appError(e, title: "updateRetailer");
    } finally {
      isLoading.value = false;
      update(); // hide loader
    }
  }
}
