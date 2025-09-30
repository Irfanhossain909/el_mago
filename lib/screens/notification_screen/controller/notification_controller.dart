import 'package:el_mago/models/notification_model/notification_model.dart';
import 'package:el_mago/screens/profile_screen/controller/profile_controller.dart';
import 'package:el_mago/services/repository/notification_repository.dart';
import 'package:el_mago/services/socket/socket_service.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationRepository notificationRepository =
      NotificationRepository.instance;

  final ScrollController notificationScrollController = ScrollController();
  SocketAllOparations socketAllOparations = SocketAllOparations.instance;
  ProfileController profileController = Get.find<ProfileController>();

  RxList<Result> notifications = <Result>[].obs;

  int notifyLimit = 10;
  RxBool isNotificationMoreLode = false.obs;
  RxBool isNotificationLastPage = false.obs;
  int notifyPage = 1;
  RxBool isNotificationLoading = false.obs;

  Future<void> fetchNotification() async {
    try {
      if (isNotificationLastPage.value) return;
      isNotificationLoading.value = true;

      isNotificationMoreLode.value = true;
      update();

      var response = await notificationRepository.getAllNotifications(
        page: notifyPage,
        limit: notifyLimit,
      );

      if (response.isNotEmpty) {
        if (notifyPage == 1) {
          notifications.value = response;
        } else {
          notifications.addAll(response);
          isNotificationLoading.value = false;
        }

        if (response.length < notifyLimit) {
          isNotificationLastPage.value = true;
        }

        update();
      } else {
        isNotificationLastPage.value = true;
        AppPrint.appError("response Empty from notification repository");
        update();
        isNotificationLoading.value = false;
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchNotification");
    } finally {
      isNotificationLoading.value = false;
      isNotificationMoreLode.value = false;
      update();
    }
  }

  void readSocketMessage() {
    try {
      // Check if socket is connected
      if (!socketAllOparations.isConnected) {
        AppPrint.appError(
          "Socket not connected, retrying in 2 seconds...",
          title: "readSocketMessage",
        );
        Future.delayed(const Duration(seconds: 2), () {
          readSocketMessage();
        });
        return;
      }

      final eventName =
          "notification::${profileController.profileData.value?.id}";
      AppPrint.appLog("Setting up socket listener for event: $eventName");

      socketAllOparations.readEvent(
        event: eventName,
        handler: (data) {
          AppPrint.appLog("Received notification data: $data");

          try {
            // New notification top e add hobe
            final newNotification = Result.fromJson(data);
            notifications.insert(0, newNotification);
            notifications.refresh(); // Force UI update
            update();

            AppPrint.appLog(
              "New notification added to top. Total notifications: ${notifications.length}",
            );
          } catch (e) {
            AppPrint.appError(
              "Error parsing notification data: $e",
              title: "readSocketMessage",
            );
          }
        },
      );

      AppPrint.appLog("Socket event listener setup completed");
    } catch (e) {
      AppPrint.appError(e, title: "readSocketMessage");
    }
  }

  Future<void> refreshNotification() async {
    notifyPage = 1;
    isNotificationLastPage.value = false;
    notifications.clear();
    await fetchNotification();
  }

  void notificationScrollListener() {
    if (notificationScrollController.position.pixels >=
        notificationScrollController.position.maxScrollExtent - 100) {
      if (!isNotificationLastPage.value && !isNotificationMoreLode.value) {
        notifyPage++;
        fetchNotification();
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Add delay to ensure socket is connected
    Future.delayed(const Duration(milliseconds: 500), () {
      readSocketMessage();
    });

    notificationScrollController.addListener(notificationScrollListener);
    fetchNotification();
  }

  @override
  void onClose() {
    notificationScrollController.dispose();
    super.onClose();
  }

  // Test method to manually add notification for testing
  void addTestNotification() {
    final testNotification = Result(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: "Test Notification",
      message: "This is a test notification added at ${DateTime.now()}",
      read: false,
      createdAt: DateTime.now(),
    );

    notifications.insert(0, testNotification);
    notifications.refresh();
    update();

    AppPrint.appLog("Test notification added. Total: ${notifications.length}");
  }
}
