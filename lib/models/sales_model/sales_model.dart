class SalesModel {
  final bool success;
  final String message;
  final Map<String, List<MonthlySales>> data;

  SalesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<MonthlySales>> salesData = {};

    if (json['data'] != null) {
      final Map<String, dynamic> dataMap = json['data'] as Map<String, dynamic>;

      for (String year in dataMap.keys) {
        final List<dynamic> monthlyDataList = dataMap[year] as List<dynamic>;
        salesData[year] = monthlyDataList
            .map((monthData) => MonthlySales.fromJson(monthData))
            .toList();
      }
    }

    return SalesModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: salesData,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dataJson = {};

    data.forEach((year, monthlySalesList) {
      dataJson[year] = monthlySalesList
          .map((monthly) => monthly.toJson())
          .toList();
    });

    return {'success': success, 'message': message, 'data': dataJson};
  }

  // Helper method to get sales data for a specific year
  List<double> getSalesDataForYear(String year) {
    if (data.containsKey(year)) {
      return data[year]!.map((monthly) => monthly.sales).toList();
    }
    return List.filled(12, 0.0); // Return 12 zeros if year not found
  }

  // Helper method to get total sales for a specific year
  double getTotalSalesForYear(String year) {
    if (data.containsKey(year)) {
      return data[year]!.fold(0.0, (sum, monthly) => sum + monthly.sales);
    }
    return 0.0;
  }

  // Helper method to get available years
  List<String> getAvailableYears() {
    return data.keys.toList()..sort();
  }
}

class MonthlySales {
  final String month;
  final double sales;

  MonthlySales({required this.month, required this.sales});

  factory MonthlySales.fromJson(Map<String, dynamic> json) {
    return MonthlySales(
      month: json['month'] ?? '',
      sales: (json['sales'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'month': month, 'sales': sales};
  }
}
