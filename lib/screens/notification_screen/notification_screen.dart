import 'package:el_mago/const/app_color.dart';
import 'package:el_mago/screens/notification_screen/controller/notification_controller.dart';
import 'package:el_mago/utils/app_size.dart';
import 'package:el_mago/widgets/app_text/app_text.dart';
import 'package:el_mago/widgets/appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(
            title: "Notification",
            action: [
              // Test button for debugging
              IconButton(
                icon: Icon(Icons.add_alert),
                onPressed: () {
                  controller.addTestNotification();
                },
                tooltip: "Add Test Notification",
              ),
            ],
          ),
          body: _buildBody(controller),
        );
      },
    );
  }

  Widget _buildBody(NotificationController controller) {
    return Obx(() {
      if (controller.notifications.isEmpty) {
        if (controller.isNotificationMoreLode.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: AppText(
            data: "No notifications available",
            fontSize: AppSize.width(value: 16),
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          await controller.refreshNotification();
        },
        child: ListView.builder(
          controller: controller.notificationScrollController,
          padding: EdgeInsets.only(top: AppSize.width(value: 10)),
          itemCount:
              controller.notifications.length +
              (controller.isNotificationMoreLode.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < controller.notifications.length) {
              final notification = controller.notifications[index];
              return NotificationCard(
                isRead: notification.read ?? false,
                title: notification.title ?? "No Title",
                message: notification.message ?? "No Message",
                time: notification.createdAt != null
                    ? _formatTime(notification.createdAt!)
                    : "Unknown",
              );
            } else {
              // Loading indicator for pagination
              if (controller.isNotificationLastPage.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize.width(value: 16),
                  ),
                  child: Center(
                    child: AppText(
                      data: "No more notifications",
                      fontSize: AppSize.width(value: 14),
                      fontWeight: FontWeight.w400,
                      color: AppColor.black,
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppSize.width(value: 16),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      );
    });
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} m';
    } else {
      return 'now';
    }
  }
}

class NotificationCard extends StatelessWidget {
  final String? title;
  final String? message;
  final String? time;
  final bool isRead;
  final VoidCallback? onTap;
  const NotificationCard({
    super.key,
    this.title,
    this.message,
    this.time,
    this.isRead = false,
    this.onTap,
  });

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
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: isRead
              ? AppColor.blue500.withValues(alpha: 0.1)
              : AppColor.white,
        ),
        child: Row(
          spacing: AppSize.width(value: 12),
          children: [
            Container(
              width: AppSize.width(value: 30),
              height: AppSize.width(value: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColor.blue500.withValues(alpha: 0.1),
              ),
              child: Icon(
                Icons.notification_add,
                color: AppColor.blackCard.withValues(alpha: 0.7),
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
