import 'package:el_mago/models/notification_model/notification_model.dart';
import 'package:el_mago/services/repository/notification_repository.dart';
import 'package:el_mago/widgets/app_log/app_print.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  NotificationRepository notificationRepository =
      NotificationRepository.instance;

  final ScrollController notificationScrollController = ScrollController();

  RxList<Result> notifications = <Result>[].obs;

  int notifyLimit = 10;
  RxBool isNotificationMoreLode = false.obs;
  RxBool isNotificationLastPage = false.obs;
  int notifyPage = 1;

  Future<void> fetchNotification() async {
    try {
      if (isNotificationLastPage.value) return;

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
        }

        if (response.length < notifyLimit) {
          isNotificationLastPage.value = true;
        }

        update();
      } else {
        isNotificationLastPage.value = true;
        AppPrint.appError("response Empty from notification repository");
        update();
      }
    } catch (e) {
      AppPrint.appError(e, title: "fetchNotification");
    } finally {
      isNotificationMoreLode.value = false;
      update();
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
    notificationScrollController.addListener(notificationScrollListener);
    fetchNotification();
    super.onInit();
  }

  @override
  void onClose() {
    notificationScrollController.dispose();
    super.onClose();
  }
}
