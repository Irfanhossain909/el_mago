import 'package:get/get.dart';

class SalesMySalesScreenController extends GetxController {
  // --- Data Store ---
  // A map holding all available sales data, keyed by year.
  final Map<int, List<double>> yearlySalesData = {
    2024: [
      1500,
      2000,
      1800,
      2500,
      3000,
      1200,
      400,
      2700,
      700,
      3200,
      2500,
      1300,
    ],
    2025: [
      1800,
      2500,
      2200,
      2800,
      3200,
      1000,
      800,
      3000,
      1200,
      3500,
      2700,
      1600,
    ],
    2026: [
      2200,
      2700,
      2400,
      3100,
      3500,
      1500,
      900,
      3300,
      1400,
      3800,
      2900,
      1900,
    ], // New 2026 data
  };

  // --- State for Year Selection ---
  // This index tracks the starting year of the comparison pair.
  // e.g., index 0 = (2024, 2025), index 1 = (2025, 2026)
  var currentYearIndex = 0.obs;

  // --- Computed Properties for the UI ---
  // These getters dynamically provide the correct data to the UI based on the currentYearIndex.

  // The first year in the current comparison pair.
  int get displayYear1 =>
      yearlySalesData.keys.elementAt(currentYearIndex.value);
  // The second year in the current comparison pair.
  int get displayYear2 =>
      yearlySalesData.keys.elementAt(currentYearIndex.value + 1);

  // The sales data for the first displayed year.
  List<double> get displayData1 => yearlySalesData[displayYear1]!;
  // The sales data for the second displayed year.
  List<double> get displayData2 => yearlySalesData[displayYear2]!;

  // The total sales for the first displayed year.
  double get displayTotal1 => displayData1.reduce((a, b) => a + b);
  // The total sales for the second displayed year.
  double get displayTotal2 => displayData2.reduce((a, b) => a + b);

  // --- Methods to Change Years ---
  void nextYear() {
    // Prevent going out of bounds
    if (currentYearIndex.value < yearlySalesData.length - 2) {
      currentYearIndex.value++;
    }
  }

  void previousYear() {
    // Prevent going out of bounds
    if (currentYearIndex.value > 0) {
      currentYearIndex.value--;
    }
  }
}
