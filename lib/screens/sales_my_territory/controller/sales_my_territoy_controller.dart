import 'package:el_mago/services/repository/profile_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesMyTerritoryController extends GetxController {
  // --- STATE ---

  // Repository instance
  final ProfileRepository _profileRepository = ProfileRepository();

  // Loading state
  var isLoading = false.obs;
  var isLoadingProfile = false.obs;

  // This would typically be fetched from an API
  final allTerritories = <String>[
    'California',
    'Texas',
    'Florida',
    'New York',
    'Illinois',
    'Pennsylvania',
    'Ohio',
    'Georgia',
    'Colorado',
  ].obs;

  // The list of currently selected territories
  var selectedTerritories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    AppPrint.appLog("🚀 SalesMyTerritoryController onInit called");
    _resetController();
    loadExistingTerritories();
  }

  @override
  void onReady() {
    super.onReady();
    AppPrint.appLog("✅ SalesMyTerritoryController onReady called");
  }

  // Reset controller state
  void _resetController() {
    selectedTerritories.clear();
    isLoading.value = false;
    isLoadingProfile.value = false;
    AppPrint.appLog(
      "🔄 Controller state reset. Selected territories: ${selectedTerritories.join(', ')}",
    );
  }

  // Load existing territories from profile
  Future<void> loadExistingTerritories() async {
    try {
      isLoadingProfile.value = true;
      AppPrint.appLog("🔄 Loading existing territories...");
      final profileData = await _profileRepository.getProfileData();

      AppPrint.appLog("📥 Profile data received: ${profileData?.toJson()}");

      if (profileData != null && profileData.territory != null) {
        AppPrint.appLog("🎯 Raw territory data: ${profileData.territory}");
        AppPrint.appLog(
          "🎯 Territory data type: ${profileData.territory.runtimeType}",
        );

        // Cast the dynamic list to List<String>
        final territories = profileData.territory!.cast<String>();
        AppPrint.appLog("✅ Casted territories: $territories");

        selectedTerritories.assignAll(territories);
        AppPrint.appLog(
          "✅ Loaded existing territories: ${selectedTerritories.join(', ')}",
        );
      } else {
        AppPrint.appLog(
          "ℹ️ No existing territories found or profile data is null",
        );
        selectedTerritories.clear(); // Ensure it's empty
      }
    } catch (e) {
      AppPrint.appError(e, title: "loadExistingTerritories");
      selectedTerritories.clear(); // Clear on error
    } finally {
      isLoadingProfile.value = false;
      AppPrint.appLog(
        "🏁 Territory loading completed. Selected: ${selectedTerritories.join(', ')}",
      );
    }
  }

  // --- GETTERS (Computed Properties) ---

  // Generates the text for the dropdown header based on the current selection
  String get selectedText {
    if (selectedTerritories.isEmpty) {
      return 'Select Your Territory';
    } else if (selectedTerritories.length == 1) {
      return selectedTerritories.first;
    } else {
      return '${selectedTerritories.length} territories selected';
    }
  }

  // --- METHODS ---

  // Toggles the selection status of a single territory
  void toggleTerritory(String territory) {
    if (selectedTerritories.contains(territory)) {
      selectedTerritories.remove(territory);
    } else {
      selectedTerritories.add(territory);
    }
  }

  // Selects all available territories
  void selectAll() {
    selectedTerritories.assignAll(allTerritories);
  }

  // Clears all current selections
  void clearAll() {
    selectedTerritories.clear();
    AppPrint.appLog("🧹 All territories cleared manually");
  }

  // Public method to reset controller (for debugging)
  void resetController() {
    _resetController();
    AppPrint.appLog("🔄 Controller manually reset");
  }

  // Save territory functionality with API integration
  Future<void> saveTerritory() async {
    if (selectedTerritories.isEmpty) {
      Get.snackbar(
        "No Selection",
        "Please select at least one territory to save.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    try {
      isLoading.value = true;
      AppPrint.appLog("Saving territories: ${selectedTerritories.join(', ')}");

      bool success = await _profileRepository.updateTerritory(
        territory: selectedTerritories.toList(),
      );

      if (success) {
        AppPrint.appLog("✅ Territories saved successfully");
        Get.snackbar(
          duration: Duration(milliseconds: 800),
          "Success",
          "Your territories have been saved successfully.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue,
          colorText: Get.theme.colorScheme.onPrimary,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to save territories. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.colorScheme.onError,
        );
      }
    } catch (e) {
      AppPrint.appError(e, title: "saveTerritory");
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
