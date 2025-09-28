import 'package:el_mago/models/sales_model/sales_model.dart';
import 'package:el_mago/services/repository/sales_repository.dart';
import 'package:el_mago/widgets/app_log/error_log.dart';
import 'package:get/get.dart';

class SalesMySalesScreenController extends GetxController {
  // --- Dependencies ---
  final SalesRepository _salesRepository = SalesRepository();

  // --- State Variables ---
  var isLoading = false.obs;
  var salesData = Rxn<SalesModel>();
  var availableYears = <String>[].obs;
  var currentYearIndex = 0.obs;

  // --- Computed Properties for the UI ---
  // The first year in the current comparison pair.
  String get displayYear1 {
    if (availableYears.length > currentYearIndex.value) {
      return availableYears[currentYearIndex.value];
    }
    return '2024'; // fallback
  }

  // The second year in the current comparison pair.
  String get displayYear2 {
    if (availableYears.length > currentYearIndex.value + 1) {
      return availableYears[currentYearIndex.value + 1];
    }
    return '2025'; // fallback
  }

  // The sales data for the first displayed year.
  List<double> get displayData1 {
    if (salesData.value != null) {
      return salesData.value!.getSalesDataForYear(displayYear1);
    }
    return List.filled(12, 0.0);
  }

  // The sales data for the second displayed year.
  List<double> get displayData2 {
    if (salesData.value != null) {
      return salesData.value!.getSalesDataForYear(displayYear2);
    }
    return List.filled(12, 0.0);
  }

  // The total sales for the first displayed year.
  double get displayTotal1 {
    if (salesData.value != null) {
      return salesData.value!.getTotalSalesForYear(displayYear1);
    }
    return 0.0;
  }

  // The total sales for the second displayed year.
  double get displayTotal2 {
    if (salesData.value != null) {
      return salesData.value!.getTotalSalesForYear(displayYear2);
    }
    return 0.0;
  }

  @override
  void onInit() {
    super.onInit();
    _initializeSalesData();
  }

  // Initialize with default years and fetch data
  void _initializeSalesData() {
    // Set default years to include more previous years for navigation
    final currentYear = DateTime.now().year;
    final defaultYears = [
      (currentYear - 3).toString(), // 3 years back
      (currentYear - 2).toString(), // 2 years back
      (currentYear - 1).toString(), // previous year
      currentYear.toString(), // current year
    ];

    fetchSalesData(defaultYears);
  }

  // Fetch sales data from API
  Future<void> fetchSalesData(List<String> years) async {
    try {
      isLoading.value = true;

      final result = await _salesRepository.getMySales(years);

      if (result != null) {
        salesData.value = result;
        availableYears.value = result.getAvailableYears();
        // Set default index to show (previous year, current year) comparison
        // This will be index 2 in our array: [2022, 2023, 2024, 2025, 2026]
        //                                            0     1     2     3     4
        // So index 2 shows comparison between 2024 (previous) and 2025 (current)
        final currentYear = DateTime.now().year;
        final previousYearString = (currentYear - 1).toString();
        final previousYearIndex = availableYears.indexOf(previousYearString);
        currentYearIndex.value = previousYearIndex >= 0 ? previousYearIndex : 0;
      } else {
        errorLog('Failed to fetch sales data', 'API returned null');
        // Set fallback data
        _setFallbackData(years);
      }
    } catch (e) {
      errorLog('Exception in fetchSalesData', e.toString());
      // Set fallback data in case of error
      _setFallbackData(years);
    } finally {
      isLoading.value = false;
    }
  }

  // Set fallback data in case of API failure
  void _setFallbackData(List<String> years) {
    // Create empty sales data for fallback
    Map<String, List<MonthlySales>> fallbackData = {};
    for (String year in years) {
      fallbackData[year] = List.generate(12, (index) {
        const months = [
          "Jan",
          "Feb",
          "Mar",
          "Apr",
          "May",
          "Jun",
          "Jul",
          "Aug",
          "Sep",
          "Oct",
          "Nov",
          "Dec",
        ];
        return MonthlySales(month: months[index], sales: 0.0);
      });
    }

    salesData.value = SalesModel(
      success: false,
      message: "Failed to load data",
      data: fallbackData,
    );
    availableYears.value = years;
    // Set default index to show (previous year, current year) comparison for fallback too
    final currentYear = DateTime.now().year;
    final previousYearString = (currentYear - 1).toString();
    final previousYearIndex = years.indexOf(previousYearString);
    currentYearIndex.value = previousYearIndex >= 0 ? previousYearIndex : 0;
  }

  // --- Methods to Change Years ---
  void nextYear() {
    // Prevent going out of bounds
    if (currentYearIndex.value < availableYears.length - 2) {
      currentYearIndex.value++;
    }
  }

  void previousYear() {
    // Prevent going out of bounds
    if (currentYearIndex.value > 0) {
      currentYearIndex.value--;
    }
  }

  // Method to refresh data
  Future<void> refreshData() async {
    await fetchSalesData(availableYears.toList());
  }
}
