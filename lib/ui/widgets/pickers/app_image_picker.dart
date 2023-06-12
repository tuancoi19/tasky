import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/utils/logger.dart';
import 'package:tasky/utils/os_utils.dart';
import 'package:tasky/utils/utils.dart';

class AppImagePicker extends StatefulWidget {
  final Function(File)? onSubmitImage;
  final Function? onErrorImage;
  final bool onlyImagePicker;

  const AppImagePicker({
    Key? key,
    this.onSubmitImage,
    this.onErrorImage,
    this.onlyImagePicker = false,
  }) : super(key: key);

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  late final File _image;
  final picker = ImagePicker();

  late PermissionStatus permissionCamera;
  late PermissionStatus permissionGallery;
  late bool checkOS;

  @override
  void initState() {
    getAccessPermission();
    super.initState();
  }

  void getAccessPermission() async {
    permissionCamera = await Permission.camera.status;
    checkOS = await OSUtils.checkOldAndroidVersion();
    if (!checkOS) {
      permissionGallery = await Permission.photos.status;
    }
  }

  Future<void> getImageFromCamera() async {
    try {
      FocusScope.of(context).unfocus();
      XFile? imageFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );
      if (imageFile != null) {
        await processImage(imageFile.path);
      }
    } catch (error) {
      logger.d(error);
    }
  }

  Future<void> getImageFromGallery() async {
    try {
      FocusScope.of(context).unfocus();
      XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        await processImage(imageFile.path);
      }
    } catch (error) {
      logger.d(error);
    }
  }

  Future<void> processImage(String path) async {
    File? temp = File(path);
    if ((temp.lengthSync() / 1024 / 1024) > AppConfigs.imageSize) {
      temp = await Utils.resizeImage(
        temp,
        imageSize: AppConfigs.imageSize,
      );
    }
    _image = temp ?? File(path);
    widget.onSubmitImage?.call(_image);
    if (!widget.onlyImagePicker) Get.back();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24).r,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ).r,
              child: Text(
                S.current.upload_image,
                style: AppTextStyle.blackS18Bold,
              ),
            ),
            AppButton(
              backgroundColor: AppColors.buttonBGWhite,
              title: S.current.take_photo,
              textStyle: AppTextStyle.blackS18Bold,
              cornerRadius: 8.r,
              onPressed: () async {
                if (permissionCamera != PermissionStatus.denied) {
                  if (permissionCamera == PermissionStatus.permanentlyDenied) {
                    await openAppSettings();
                  } else {
                    await getImageFromCamera();
                  }
                } else {
                  final result = await Permission.camera.request();
                  if (result != PermissionStatus.denied) {
                    if (result == PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    } else {
                      await getImageFromCamera();
                    }
                  }
                  permissionCamera = await Permission.camera.status;
                }
              },
            ),
            SizedBox(height: 8.h),
            AppButton(
              backgroundColor: AppColors.buttonBGWhite,
              title: S.current.choose_from_library,
              textStyle: AppTextStyle.blackS18Bold,
              cornerRadius: 8,
              onPressed: () async {
                if (!checkOS) {
                  if (permissionGallery != PermissionStatus.denied) {
                    if (permissionGallery ==
                        PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    } else {
                      await getImageFromGallery();
                    }
                  } else {
                    final result = await Permission.photos.request();
                    if (result != PermissionStatus.denied) {
                      if (result == PermissionStatus.permanentlyDenied) {
                        await openAppSettings();
                      } else {
                        Get.back();
                        await getImageFromGallery();
                      }
                    }
                    permissionGallery = await Permission.photos.status;
                  }
                } else {
                  await getImageFromGallery();
                }
              },
            ),
            SizedBox(height: 8.h),
            AppButton(
              backgroundColor: AppColors.buttonBGWhite,
              title: S.current.cancel,
              textStyle: AppTextStyle.blackS18Bold,
              cornerRadius: 8.r,
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
