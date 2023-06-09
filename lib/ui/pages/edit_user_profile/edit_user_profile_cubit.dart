import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

part 'edit_user_profile_state.dart';

class EditUserProfileCubit extends Cubit<EditUserProfileState> {
  EditUserProfileCubit(this.appCubit) : super(const EditUserProfileState());
  final AppCubit appCubit;


  void onValidateForm() {
    emit(
      state.copyWith(
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  void changeUserName({required String userName}) {
    emit(state.copyWith(userName: userName));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void setIsEdit(bool value) {
    emit(state.copyWith(isEditProfile: value));
  }

  void actionCancel() {
    emit(state.copyWith(
      isEditProfile: false,
      isClear: true,
    ));
  }

  void getPhotoGallery() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(image: image));
      await cropImage();
    } else {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void takePhotoCamera() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));

    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      emit(state.copyWith(image: photo));
      await cropImage();
    }
  }

  Future<void> cropImage() async {
    if (state.image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: state.image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );
      if (croppedFile != null) {
        emit(
          state.copyWith(
            imageCrop: croppedFile,
          ),
        );
      }
    }
    emit(state.copyWith(loadDataStatus: LoadStatus.success));
  }

  Future<void> saveInfo() async {
    String? urlImg;
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));

    if (state.imageCrop != null) {
      urlImg =
          await appCubit.uploadImgToFirebase(File(state.imageCrop?.path ?? ''));
      if (urlImg == null) {
        print('ERROR UPLOAD FILE URL : $urlImg');
        return;
      }
    }
    bool checkPass = await appCubit.checkPassword(state.password ?? '');
    if (checkPass) {
      print('❤️❤️❤️ - CHECK TRUE');

      await appCubit.updateUserToFirebase(
        userName: state.userName,
        pathAvatar: urlImg,
      );

      emit(state.copyWith(
        loadDataStatus: LoadStatus.success,
        isEditProfile: false,
      ));
    } else {
      AppDialog.showCustomDialog(
        content: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password error',
                style: AppTextStyle.secondaryBlackO80S21W600,
              ),
              SizedBox(height: 32.h),
              AppButton(
                height: 56.h,
                title: S.current.close,
                cornerRadius: 15.r,
                textStyle: AppTextStyle.whiteS18Bold,
                backgroundColor: AppColors.primary,
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      );
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }
}
