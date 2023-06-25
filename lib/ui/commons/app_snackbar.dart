import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void showInfo({String? title, String? message}) {
    Get.snackbar(
      title ?? "Info",
      message ?? "Empty message",
      backgroundColor: Colors.white,
      colorText: Colors.black,
      margin: const EdgeInsets.only(top: 32, left: 12, right: 12).r,
      duration: const Duration(seconds: 5),
    );
  }

  static void showWarning({String? title, String? message}) {
    Get.snackbar(
      title ?? "Warning",
      message ?? "Empty message",
      backgroundColor: Colors.amber,
      colorText: Colors.white,
      margin: const EdgeInsets.only(top: 32, left: 12, right: 12).r,
      duration: const Duration(seconds: 5),
    );
  }

  static void showError({String? title, String? message}) {
    Get.snackbar(
      title ?? "Error",
      message ?? "Empty message",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.only(top: 32, left: 12, right: 12).r,
      duration: const Duration(seconds: 5),
    );
  }

  static void showSuccess({String? title, String? message}) {
    Get.snackbar(
      title ?? "Success",
      message ?? "Empty message",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.only(top: 32, left: 12, right: 12).r,
    );
  }
}
