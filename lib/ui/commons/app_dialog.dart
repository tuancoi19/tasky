import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static void defaultDialog({
    String title = "Alert",
    String message = "",
    String? textConfirm,
    String? textCancel,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      onConfirm: onConfirm == null
          ? null
          : () {
              Get.back();
              onConfirm.call();
            },
      onCancel: onCancel == null
          ? null
          : () {
              Get.back();
              onCancel.call();
            },
      textConfirm: textConfirm,
      textCancel: textCancel,
    );
  }

  static void showCustomBottomSheet(
    BuildContext context, {
    required Widget widget,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }

  static Future<void> showCustomDialog({
    Color? color,
    double? borderRadius,
    required Widget content,
    EdgeInsets? padding,
  }) {
    return Get.dialog(
      Dialog(
        backgroundColor: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: content,
      ),
      barrierDismissible: false,
    );
  }
}
