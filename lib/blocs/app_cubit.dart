import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/database/secure_storage_helper.dart';
import 'package:tasky/database/share_preferences_helper.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/token_entity.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection("users");

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> logInWithEmailAndPassword({
    required String mail,
    required String password,
  }) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      AppDialog.showCustomDialog(
        content: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.message ?? '',
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
                  Get.back(closeOverlays: true);
                },
              )
            ],
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword({
    required String mail,
    required String password,
  }) async {
    try {
      UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      User? user = credential.user;
      if (user != null) {
        logger.log('🙍‍🙍‍🙍‍ Login success  =->>>> : $user');
        SharedPreferencesHelper.setSeenIntro(isSeen: true);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      AppDialog.showCustomDialog(
        content: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.message ?? '',
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
                  Get.back(closeOverlays: true);
                },
              )
            ],
          ),
        ),
      );
    } catch (e) {
      logger.log('LOGIN FAILED! $e');
    }
    return null;
  }

  Future saveUserToFirebase({
    required User user,
    required String userName,
  }) async {
    final newUser = {
      'user_name': userName,
      'email': user.email,
      'create_at': user.metadata.creationTime,
    };
    try {
      await userCollection.doc(user.uid).set(newUser).catchError((e) {
        logger.e('❌❌ ERROR : Save new user to firebase - ${e}');
      });
    } catch (e) {
      logger.e('❌❌ ERROR : Save new user to firebase - ${e}');
    }
  }

  Future<String?> forgotPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut().then(
          (value) => Get.offAllNamed(RouteConfig.splash),
        );
  }

  void fetchProfile() {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  void updateProfile(AppUser user) {
    emit(state.copyWith(user: user));
  }

  Future<bool> saveSession({
    String? token,
    String refreshToken = '',
    AppUser? currentAppUser,
  }) async {
    await _saveToSecureStorage(token: token ?? '', refreshToken: refreshToken);
    await _saveToSharedPreferences(currentAppUser);

    return true;
  }

  Future<void> _saveToSecureStorage(
      {String token = '', String refreshToken = ''}) async {
    final tokenEntity =
        TokenEntity(accessToken: token, refreshToken: refreshToken);
    final secureStorageHelper = SecureStorageHelper.instance;

    secureStorageHelper.removeToken();
    secureStorageHelper.saveToken(tokenEntity);
  }

  Future<void> _saveToSharedPreferences(
    AppUser? currentAppUser,
  ) async {
    final sharedPreferencesHelper = SharedPreferencesHelper();
    await sharedPreferencesHelper.setAppUser(
      currentAppUser: currentAppUser,
    );
  }

  ///Sign Out
// void signOut() async {
//   emit(state.copyWith(signOutStatus: LoadStatus.loading));
//   try {
//     await Future.delayed(const Duration(seconds: 2));
//     final sharedPreferencesHelper = SharedPreferencesHelper();
//     final secureStorageHelper = SecureStorageHelper.instance;
//
//     secureStorageHelper.removeToken();
//     await sharedPreferencesHelper.logout();
//   } catch (e) {
//     logger.e(e);
//     emit(state.copyWith(signOutStatus: LoadStatus.failure));
//   }
// }
}
