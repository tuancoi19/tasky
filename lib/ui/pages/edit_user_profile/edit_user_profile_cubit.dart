import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'edit_user_profile_state.dart';

class EditUserProfileCubit extends Cubit<EditUserProfileState> {
  EditUserProfileCubit(this.appCubit) : super(EditUserProfileState());
  final AppCubit appCubit;

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

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
      clearImg: true,
    ));
  }

  void getPhotoGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(image: image));
      await cropImage();
    }
  }

  void takePhotoCamera() async {
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
  }

  Future<void> saveInfo() async {
    //TODO
    String? urlImg;
    if (state.imageCrop != null) {
      urlImg =
          await appCubit.uploadImgToFirebase(File(state.imageCrop?.path ?? ''));
      if (urlImg == null) {
        print('ERROR UPLOAD FILE URL : $urlImg');
        return;
      }
    }
  }
}
