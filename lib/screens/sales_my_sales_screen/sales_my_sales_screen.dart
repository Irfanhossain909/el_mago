// import 'package:el_mago/const/app_color.dart';
// import 'package:el_mago/const/assets_icons_path.dart';
// import 'package:el_mago/screens/sales_my_sales_screen/controller/sales_my_sales_screen_controller.dart';
// import 'package:el_mago/utils/app_size.dart';
// import 'package:el_mago/widgets/app_text/app_text.dart';
// import 'package:el_mago/widgets/appbar/custom_appbar.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class SalesMySalesScreen extends StatelessWidget {
//   const SalesMySalesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<SalesMySalesScreenController>();
//     return Scaffold(
//       appBar: CustomAppbar(title: "My Sales"),
//       body: Obx(
//         () => controller.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.0,
//                   vertical: 10,
//                 ),
//                 child: Column(
//                   children: [
//                     // Top summary cards now display data based on the selected years
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _SalesSummaryCard(
//                             amount: controller.displayTotal2,
//                             year: "${controller.displayYear2} Total",
//                           ),
//                         ),
//                         SizedBox(width: AppSize.width(value: 16)),
//                         Expanded(
//                           child: _SalesSummaryCard(
//                             amount: controller.displayTotal1,
//                             year: "${controller.displayYear1} Total",
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: AppSize.height(value: 24)),
//                     // Chart section
//                     Expanded(
//                       flex: 3, // Give the chart card more vertical space
//                       child: _YearComparisonChartCard(controller: controller),
//                     ),
//                     const Spacer(
//                       flex: 4,
//                     ), // Add a spacer to create empty space at the bottom
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

// // A widget for the purple summary cards at the top
// class _SalesSummaryCard extends StatelessWidget {
//   final double amount;
//   final String year;

//   const _SalesSummaryCard({required this.amount, required this.year});

//   @override
//   Widget build(BuildContext context) {
//     final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//       decoration: BoxDecoration(
//         color: AppColor.blue,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//             child: Image.asset(AssetsPath.dollerColor, width: 16, height: 16),
//           ),
//           SizedBox(width: AppSize.width(value: 12)),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppText(
//                 data: formatter.format(amount),
//                 color: AppColor.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               SizedBox(height: AppSize.height(value: 4)),
//               AppText(
//                 data: year,
//                 color: AppColor.white.withOpacity(0.8),
//                 fontSize: 14,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// // A widget for the card containing the chart, header, and legend
// class _YearComparisonChartCard extends StatelessWidget {
//   final SalesMySalesScreenController controller;
//   const _YearComparisonChartCard({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.15),
//             spreadRadius: 5,
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Chart Header with functional arrows
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const AppText(
//                 data: "Year Comparison",
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//               Row(
//                 children: [
//                   Obx(
//                     () => AppText(
//                       data:
//                           "${controller.displayYear1}-${controller.displayYear2}",
//                       fontSize: 14,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(width: AppSize.width(value: 8)),
//                   InkWell(
//                     onTap: controller.previousYear,
//                     child: const Icon(
//                       Icons.arrow_back_ios,
//                       size: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: controller.nextYear,
//                     child: const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: AppSize.height(value: 24)),
//           // The Bar Chart itself, now dynamically driven by the controller
//           Expanded(
//             child: Obx(
//               () => _YearComparisonChart(
//                 year1: controller.displayYear1,
//                 year2: controller.displayYear2,
//                 data1: controller.displayData1,
//                 data2: controller.displayData2,
//               ),
//             ),
//           ),
//           SizedBox(height: AppSize.height(value: 16)),
//           // Chart Legend, also dynamic
//           Obx(
//             () => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _LegendItem(
//                   color: const Color(0xFF82A5E7),
//                   text: "${controller.displayYear1}",
//                 ),
//                 const SizedBox(width: 20),
//                 _LegendItem(
//                   color: const Color(0xFF86D5A2),
//                   text: "${controller.displayYear2}",
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // The main Bar Chart widget, styled to match the image
// class _YearComparisonChart extends StatelessWidget {
//   final String year1;
//   final String year2;
//   final List<double> data1;
//   final List<double> data2;

//   const _YearComparisonChart({
//     required this.year1,
//     required this.year2,
//     required this.data1,
//     required this.data2,
//   });

//   @override
//   Widget build(BuildContext context) {
//     const double barWidth = 8;
//     const color2024 = Color(0xFF82A5E7);
//     const color2025 = Color(0xFF86D5A2);

//     // Calculate dynamic max Y value based on the data
//     double maxValue = 0;
//     for (int i = 0; i < data1.length; i++) {
//       if (data1[i] > maxValue) maxValue = data1[i];
//       if (data2[i] > maxValue) maxValue = data2[i];
//     }
//     // Add some padding to the max value, minimum 1000
//     double maxY = maxValue > 0 ? (maxValue * 1.2).ceilToDouble() : 4000;
//     if (maxY < 1000) maxY = 4000;

//     return BarChart(
//       BarChartData(
//         maxY: maxY,
//         alignment: BarChartAlignment.spaceAround,
//         borderData: FlBorderData(show: false),
//         gridData: FlGridData(
//           show: true,
//           drawVerticalLine: false,
//           getDrawingHorizontalLine: (value) =>
//               const FlLine(color: Color(0xffe7e8ec), strokeWidth: 1),
//         ),
//         titlesData: FlTitlesData(
//           topTitles: const AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           rightTitles: const AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 40,
//               interval: maxY > 5000 ? 2000 : 1000,
//               getTitlesWidget: (value, meta) {
//                 return Text(
//                   '${value.toInt()}',
//                   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                 );
//               },
//             ),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 const months = [
//                   "Jan",
//                   "Feb",
//                   "Mar",
//                   "Apr",
//                   "May",
//                   "Jun",
//                   "Jul",
//                   "Aug",
//                   "Sep",
//                   "Oct",
//                   "Nov",
//                   "Dec",
//                 ];
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 4.0),
//                   child: Text(
//                     months[value.toInt()],
//                     style: const TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         barGroups: List.generate(12, (index) {
//           return BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(
//                 toY: data1[index],
//                 color: color2024,
//                 width: barWidth,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4),
//                   topRight: Radius.circular(4),
//                 ),
//               ),
//               BarChartRodData(
//                 toY: data2[index],
//                 color: color2025,
//                 width: barWidth,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(4),
//                   topRight: Radius.circular(4),
//                 ),
//               ),
//             ],
//           );
//         }),
//         barTouchData: BarTouchData(
//           enabled: true,
//           touchTooltipData: BarTouchTooltipData(
//             getTooltipColor: (_) => Colors.black87,
//             getTooltipItem: (group, groupIndex, rod, rodIndex) {
//               // The tooltip now dynamically displays the correct year
//               String year = rodIndex == 0 ? year1.toString() : year2.toString();
//               return BarTooltipItem(
//                 '$year\n',
//                 const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(
//                     text: '\$${rod.toY.toInt()}',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// // A widget for the legend items below the chart
// class _LegendItem extends StatelessWidget {
//   final Color color;
//   final String text;
//   const _LegendItem({required this.color, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         const SizedBox(width: 6),
//         Text(text, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//       ],
//     );
//   }
// }
