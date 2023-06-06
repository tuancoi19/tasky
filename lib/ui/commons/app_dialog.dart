import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_text_button.dart';

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
    required Widget content,
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

  static Future<void> showConfirmDialog({
    Color? color,
    required Function() onConfirm,
    required String title,
    required String message,
    bool? isLoading,
  }) async {
    await showCustomDialog(
      content: Padding(
        padding: const EdgeInsets.all(24).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title,
                style: AppTextStyle.blackS18Bold,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              message,
              style: AppTextStyle.blackS16W400,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12).r,
                    child: Text(
                      S.current.close,
                      style: AppTextStyle.primaryO50S14W400.copyWith(
                        color: color,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.h),
                AppTextButton(
                  onPressed: onConfirm,
                  isLoading: isLoading ?? false,
                  backgroundColor: color ?? AppColors.primary,
                  cornerRadius: 10.r,
                  height: 48.h,
                  title: S.current.proceed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
