import 'package:el_mago/const/app_color.dart';
import 'package:flutter/material.dart';

class AppProgressLine extends StatelessWidget {
  final double maxValue; // মোট value
  final double currentValue; // বর্তমান value
  final Color progressColor; // প্রগ্রেস রঙ
  final double height; // bar height
  final double borderRadius; // কোণ গোলাকার করার জন্য

  const AppProgressLine({
    super.key,
    required this.maxValue,
    required this.currentValue,
    this.progressColor = Colors.blue,
    this.height = 20,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    // progress হিসাব করা
    double percentage = (currentValue / maxValue).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress Bar
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.lightGray,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Stack(
            children: [
              // Inner progress
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: MediaQuery.of(context).size.width * percentage,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
