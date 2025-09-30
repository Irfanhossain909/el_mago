import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/sales_my_territory/controller/sales_my_territoy_controller.dart';
import 'package:el_mago/widgets/app_text/custom_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalesMyTerritory extends StatelessWidget {
  const SalesMyTerritory({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final SalesMyTerritoryController controller =
        Get.find<SalesMyTerritoryController>();

    return Scaffold(
      appBar: CustomAppbar(title: "My Territory"),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shadowColor: Colors.black.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.white, Colors.grey.shade50],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 8),
                                const CustomText(
                                  text: "Select Your Territory States",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => controller.isLoadingProfile.value
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : _MultiSelectDropdown(
                                      controller: controller,
                                    ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => ElevatedButton(
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : controller.saveTerritory,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.blue,
                                      disabledBackgroundColor: AppColor.blue
                                          .withOpacity(0.6),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 32,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: controller.isLoading.value
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          )
                                        : const Text(
                                            'Save Territory',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Remove the old save button section
          ],
        ),
      ),
    );
  }
}

// Custom widget for the multi-select dropdown functionality
class _MultiSelectDropdown extends StatelessWidget {
  final SalesMyTerritoryController controller;

  const _MultiSelectDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display for selected items as chips
        Obx(() {
          if (controller.selectedTerritories.isEmpty) {
            return const SizedBox.shrink();
          }
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColor.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.blue.withOpacity(0.2)),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: controller.selectedTerritories.map((territory) {
                return Chip(
                  label: Text(territory),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: AppColor.blue,
                  deleteIcon: const Icon(
                    Icons.close,
                    size: 14,
                    color: Colors.white,
                  ),
                  onDeleted: () => controller.toggleTerritory(territory),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                );
              }).toList(),
            ),
          );
        }),
        // The main dropdown tile
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            childrenPadding: const EdgeInsets.all(8),
            title: Obx(
              () => Text(
                controller.selectedText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: controller.selectedTerritories.isEmpty
                      ? Colors.grey.shade600
                      : Colors.black87,
                ),
              ),
            ),
            trailing: Icon(Icons.keyboard_arrow_down, color: AppColor.blue),
            children: [
              // List of checkboxes
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: controller.allTerritories.map((territory) {
                        final isSelected = controller.selectedTerritories
                            .contains(territory);
                        return CheckboxListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          title: Text(
                            territory,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? AppColor.blue
                                  : Colors.black87,
                            ),
                          ),
                          value: isSelected,
                          activeColor: AppColor.blue,
                          onChanged: (bool? value) =>
                              controller.toggleTerritory(territory),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              // "Clear All" and "Select All" buttons
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: controller.clearAll,
                      icon: const Icon(Icons.clear_all, size: 16),
                      label: const Text('Clear All'),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    ),
                    TextButton.icon(
                      onPressed: controller.selectAll,
                      icon: const Icon(Icons.select_all, size: 16),
                      label: const Text('Select All'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColor.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
