import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBottomSheet {
  static void show(Widget bottomSheet) {
    Get.bottomSheet(
      bottomSheet,
      isDismissible: false,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(30).r,
        ),
      ),
    );
  }
}
