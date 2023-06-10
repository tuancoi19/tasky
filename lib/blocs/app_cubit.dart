import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/database/secure_storage_helper.dart';
import 'package:tasky/firebase_options.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/token_entity.dart';
import 'package:tasky/models/entities/user/user_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/utils/file_utils.dart';
import 'package:tasky/utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);

  final userCollection = FirebaseFirestore.instance.collection("users");
  final storageRef = FirebaseStorage.instance.ref('images/');

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserEntity?> logInWithEmailAndPassword({
    required String mail,
    required String password,
  }) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      UserEntity? newUser = await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user?.uid)
          .get()
          .then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          return UserEntity.fromJson(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );
      if (newUser != null) {
        final token = await credential.user?.getIdToken();
        newUser.fcmToken = token;
        newUser.userId = credential.user?.uid ?? '';
        GlobalData.instance.userID = credential.user?.uid ?? '';
        await saveSession(
          refreshToken: credential.user?.refreshToken ?? '',
          token: token,
        );
        emit(state.copyWith(user: newUser));
      }
      return newUser;
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

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<UserEntity?> getUser() async {
    UserEntity? newUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(_firebaseAuth.currentUser?.uid)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        if (doc.data() == null) {
          return null;
        }
        return UserEntity.fromJson(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
    if (newUser != null) {
      newUser.userId = _firebaseAuth.currentUser?.uid;
      emit(state.copyWith(user: newUser));
      GlobalData.instance.userID = currentUser?.uid;
      return newUser;
    }
    return null;
  }

  Future<bool> checkPassword(String password) async {
    try {
      UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: state.user?.email ?? '',
        password: password,
      );
      if (credential.user != null) {
        print('❤️❤️❤️ - TRUE');
        return true;
      } else {
        print('❤️❤️❤️ - FALSE');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> createUserWithEmailAndPassword({
    required String mail,
    required String password,
    required String userName,
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
        //save user_name
        credential.user?.updateDisplayName(userName);
        UserEntity currentUser = UserEntity(
          userName: user.displayName,
          userId: user.uid,
          email: mail,
          createAt: user.metadata.creationTime,
        );
        GlobalData.instance.userID = credential.user?.uid;
        emit(state.copyWith(user: currentUser));

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

  Future<UserEntity?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      UserCredential credentialUser =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = credentialUser.user;

      //check nếu user đã tồn tại
      UserEntity? checkAlreadyUser = await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .get()
          .then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          return UserEntity.fromJson(data);
        },
        onError: (e) => print("Error getting document: $e"),
      );

      if (user != null) {
        UserEntity currentUser = UserEntity(
          //ưu tiên lấy lại userName cũ
          userName: checkAlreadyUser?.userName ?? user.displayName,
          userId: user.uid,
          email: user.email,
          createAt: user.metadata.creationTime,
          avatarUrl: user.photoURL,
        );
        GlobalData.instance.userID = user.uid;
        emit(state.copyWith(user: currentUser));
        return currentUser;
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
    UserEntity newUser = UserEntity(
      userName: userName,
      email: user.email,
      createAt: user.metadata.creationTime,
    );
    try {
      await userCollection.doc(user.uid).set(newUser.toJson()).catchError((e) {
        logger.e('❌❌ ERROR : Save new user to firebase - $e');
      });
      emit(state.copyWith(user: newUser));
    } catch (e) {
      logger.e('❌❌ ERROR : Save new user to firebase - $e');
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

  void updateProfile(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  Future<bool> saveSession({
    String? token,
    String refreshToken = '',
  }) async {
    await _saveToSecureStorage(token: token ?? '', refreshToken: refreshToken);
    return true;
  }

  void setCurrentUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  Future<void> _saveToSecureStorage(
      {String token = '', String refreshToken = ''}) async {
    final tokenEntity =
        TokenEntity(accessToken: token, refreshToken: refreshToken);
    final secureStorageHelper = SecureStorageHelper.instance;

    secureStorageHelper.removeToken();
    secureStorageHelper.saveToken(tokenEntity);
  }

  Future<String?> uploadImgToFirebase(File file) async {
    try {
      String urlImg = await FileUtils.uploadFile(
          file: file, userID: state.user?.userId ?? '', type: 'image');
      print('🗳️🗳️🗳️🗳️ $urlImg');
      await _firebaseAuth.currentUser?.updatePhotoURL(urlImg);
      return urlImg;
    } on FirebaseException catch (e) {
      logger.e(e);
    }
    return null;
  }

  Future<String?> updateUserToFirebase(
      {String? userName, String? pathAvatar}) async {
    try {
      print('--- ${state.user?.userId}');
      final userRef = userCollection.doc(state.user?.userId ?? '');
      userRef.update({
        "user_name": userName ?? state.user?.userName,
        "avatar_url": pathAvatar ?? state.user?.avatarUrl
      }).then((value) => print("User successfully updated!"),
          onError: (e) => print("Error updating user $e"));

      UserEntity newUser = UserEntity(
        userName: userName ?? state.user?.userName,
        email: state.user?.email,
        userId: state.user?.userId,
        createAt: state.user?.createAt,
        avatarUrl: pathAvatar ?? state.user?.avatarUrl,
      );

      emit(state.copyWith(user: newUser));
    } on FirebaseException catch (e) {
      logger.e(e);
    }
    return null;
  }
}
