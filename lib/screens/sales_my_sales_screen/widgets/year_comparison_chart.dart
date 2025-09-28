import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearComparisonChart extends StatelessWidget {
  const YearComparisonChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 4500, // adjust max according to your sales
          barGroups: _getBarGroups(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const months = [
                    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                  ];
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    // Dummy data for 2024 (blue) and 2025 (green)
    final data2024 = [1500, 2000, 1800, 2500, 3000, 1200, 400, 2700, 700, 3200, 2500, 1300];
    final data2025 = [1800, 2500, 2200, 2800, 3200, 1000, 800, 3000, 1200, 3500, 2700, 1600];

    return List.generate(12, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data2024[index].toDouble(),
            color: Colors.blue,
            width: 10,
          ),
          BarChartRodData(
            toY: data2025[index].toDouble(),
            color: Colors.green,
            width: 10,
          ),
        ],
      );
    });
  }
}
