import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/ui/widgets/pickers/app_image_picker.dart';
import 'package:tasky/utils/os_utils.dart';

class TaskUploadDocumentOptions extends StatelessWidget {
  final Function(File) sendImage;
  final Function(File) sendTextFile;

  const TaskUploadDocumentOptions({
    Key? key,
    required this.sendImage,
    required this.sendTextFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ).r,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              onPressed: () {
                showModalBottomSheet(
                  isDismissible: false,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: const Radius.circular(20).r,
                    ),
                  ),
                  builder: (BuildContext context) {
                    return SelectUploadImage(
                      onSubmitImage: sendImage,
                    );
                  },
                );
              },
              title: S.current.upload_image,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () async {
                await pickFile();
              },
              title: S.current.upload_file,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            ),
            SizedBox(height: 8.h),
            AppButton(
              onPressed: () {
                Get.back();
              },
              title: S.current.cancel,
              textStyle: AppTextStyle.blackS18Bold,
              backgroundColor: AppColors.buttonBGWhite,
              cornerRadius: 8.r,
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickFile() async {
    final checkOS = await OSUtils.checkOldAndroidVersion();

    if (checkOS) {
      PermissionStatus permissionFile = await Permission.storage.status;

      if (permissionFile != PermissionStatus.denied) {
        if (permissionFile == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        } else {
          Get.back();
          await openFilePicker();
        }
      } else {
        final result = await Permission.storage.request();
        if (result != PermissionStatus.denied) {
          if (result == PermissionStatus.permanentlyDenied) {
            Get.back();
            openAppSettings();
          } else {
            Get.back();
            await openFilePicker();
          }
        }
        permissionFile = await Permission.storage.status;
      }
    } else {
      Get.back();
      await openFilePicker();
    }
  }

  Future<void> openFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: AppConfigs.listTextFileType,
      allowMultiple: false,
    );
    if (result != null) {
      sendTextFile.call(
        File(result.files.single.path ?? ''),
      );
    }
  }
}
