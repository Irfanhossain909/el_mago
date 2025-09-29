import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:get/get.dart';

class SalesMyTerritoryController extends GetxController {
  // --- STATE ---

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
  ].obs;

  // The list of currently selected territories
  var selectedTerritories = <String>[].obs;

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
  }

  // Placeholder for the save functionality
  void saveTerritory() {
    if (selectedTerritories.isEmpty) {
      Get.snackbar(
        "No Selection",
        "Please select at least one territory to save.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Here you would make your API call to save the data
      AppPrint.appLog("Saving territories: ${selectedTerritories.join(', ')}");
      Get.snackbar(
        "Success",
        "Your territories have been saved successfully.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
