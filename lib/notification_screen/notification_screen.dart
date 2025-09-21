import 'package:flutter/material.dart';
import 'package:tinnierenee12/const/app_color.dart';
import 'package:tinnierenee12/utils/app_size.dart';
import 'package:tinnierenee12/widget/app_text/app_text.dart';
import 'package:tinnierenee12/widget/appbar/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of notifications
    final List<Map<String, String>> notifications = [
      {
        "title": "OTP Verify!",
        "message": "Your OTP is required to close the trip. Enter it now.",
        "time": "2 h",
      },
      {
        "title": "New Trip Request",
        "message": "You have a new trip request waiting for approval.",
        "time": "1 d",
      },
      {
        "title": "Promo Code",
        "message": "Use promo code 'NEW20' for 20% off on your next ride.",
        "time": "3 d",
      },
    ];

    return Scaffold(
      appBar: CustomAppbar(title: "Notification"),
      body: ListView.builder(
        padding: EdgeInsets.only(top: AppSize.width(value: 10)),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            title: notifications[index]['title']!,
            message: notifications[index]['message']!,
            time: notifications[index]['time']!,
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String? title;
  final String? message;
  final String? time;
  const NotificationCard({super.key, this.title, this.message, this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(value: 16),
        vertical: AppSize.width(value: 4),
      ),
      child: Container(
        padding: EdgeInsets.all(AppSize.width(value: 16)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.white,
        ),
        child: Row(
          spacing: AppSize.width(value: 12),
          children: [
            Container(
              width: AppSize.width(value: 30),
              height: AppSize.width(value: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColor.purple.withValues(alpha: 0.3),
              ),
              child: Icon(
                Icons.notification_add,
                color: AppColor.purple.withValues(alpha: 0.7),
                size: 16, // Adjust the size as needed
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                spacing: AppSize.width(value: 8),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: title ?? "No Data",
                    fontSize: AppSize.width(value: 16),
                    fontWeight: FontWeight.w600,
                    color: AppColor.black,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          data: message ?? "No Data",
                          fontSize: AppSize.width(value: 12),
                          fontWeight: FontWeight.w400,
                          color: AppColor.black,
                        ),
                      ),
                      AppText(
                        data: time ?? "No Data",
                        fontSize: AppSize.width(value: 12),
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}
