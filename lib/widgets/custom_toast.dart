import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType { success, error, warning, info }

class CustomToast {
  static void show({
    required BuildContext context,
    required String message,
    required ToastType type,
  }) {
    FToast fToast = FToast();
    fToast.init(context);

    // Style define
    Color bgColor;
    IconData icon;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green.shade600;
        icon = Icons.check_circle;
        break;
      case ToastType.error:
        bgColor = Colors.red.shade600;
        icon = Icons.error;
        break;
      case ToastType.warning:
        bgColor = Colors.orange.shade700;
        icon = Icons.warning;
        break;
      case ToastType.info:
        bgColor = Colors.blue.shade600;
        icon = Icons.info;
        break;
    }

    // Toast widget
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(2, 2),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );

    // Show toast
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
