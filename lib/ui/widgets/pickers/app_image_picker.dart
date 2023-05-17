import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/utils/logger.dart';
import 'package:tasky/utils/utils.dart';

class SelectUploadImage extends StatefulWidget {
  final Function(File)? onSubmitImage;
  final Function? onErrorImage;

  const SelectUploadImage({
    Key? key,
    this.onSubmitImage,
    this.onErrorImage,
  }) : super(key: key);

  @override
  State<SelectUploadImage> createState() => _SelectUploadImageState();
}

class _SelectUploadImageState extends State<SelectUploadImage> {
  late final File _image;
  late AppCubit appCubit;
  final picker = ImagePicker();

  late PermissionStatus permissionCamera;
  late PermissionStatus permissionGallery;

  @override
  void initState() {
    getAccessPermission();
    super.initState();
    appCubit = BlocProvider.of(context);
  }

  void getAccessPermission() async {
    permissionCamera = await Permission.camera.status;
    permissionGallery = await Permission.photos.status;
  }

  Future getImageFromCamera() async {
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
  }

  Future<bool> checkDevice() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      if (sdkInt < 33) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: Text(
                S.current.upload_photo,
                style: AppTextStyle.blackS18Bold,
              ),
            ),
            AppButton(
              backgroundColor: AppColors.buttonBGWhite,
              title: S.current.take_photo,
              textStyle: AppTextStyle.blackS18Bold,
              cornerRadius: 8,
              onPressed: () async {
                if (permissionCamera != PermissionStatus.denied) {
                  if (permissionCamera == PermissionStatus.permanentlyDenied) {
                    openAppSettings();
                  } else {
                    Get.back();
                    await getImageFromCamera();
                  }
                } else {
                  final result = await Permission.camera.request();
                  if (result != PermissionStatus.denied) {
                    if (result == PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    } else {
                      Get.back();
                      await getImageFromCamera();
                    }
                  }
                  permissionCamera = await Permission.camera.status;
                }
              },
            ),
            const SizedBox(height: 8),
            AppButton(
              backgroundColor: AppColors.buttonBGWhite,
              title: S.current.choose_from_library,
              textStyle: AppTextStyle.blackS18Bold,
              cornerRadius: 8,
              onPressed: () async {
                if (permissionGallery != PermissionStatus.denied) {
                  if (permissionGallery == PermissionStatus.permanentlyDenied) {
                    openAppSettings();
                  } else {
                    Get.back();
                    await getImageFromGallery();
                  }
                } else {
                  final result = await Permission.photos.request();
                  if (result != PermissionStatus.denied) {
                    if (result == PermissionStatus.permanentlyDenied) {
                      openAppSettings();
                    } else {
                      Get.back();
                      await getImageFromGallery();
                    }
                  }
                  permissionGallery = await Permission.photos.status;
                }
              },
            ),
            const SizedBox(height: 8),
            AppButton(
              backgroundColor: AppColors.buttonBGWhite,
              title: S.current.cancel,
              textStyle: AppTextStyle.blackS18Bold,
              cornerRadius: 8,
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
