import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/utils/logger.dart';

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

  Future<void> cropImage({required File image}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: S.current.cropper,
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: S.current.cropper,
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
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> saveInfo() async {
    String? urlImg;
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));

    if (state.imageCrop != null) {
      urlImg =
          await appCubit.uploadImgToFirebase(File(state.imageCrop?.path ?? ''));
      if (urlImg == null) {
        logger.log('ERROR UPLOAD FILE URL : $urlImg');
        return;
      }
    }
    bool checkPass = await appCubit.checkPassword(state.password ?? '');
    if (checkPass) {
      logger.log('❤️❤️❤️ - CHECK TRUE');

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
