import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/pages/authentication/authentication_cubit.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {

  SignupCubit({
    required this.authenticationCubit,
    required this.appCubit,

  }) : super(const SignupState());

  final AuthenticationCubit authenticationCubit;
  final AppCubit appCubit;

  Future<void> signUp({
    required String mail,
    required String password,
  }) async {
    authenticationCubit.setLoading(LoadStatus.loading);
      User? user = await appCubit
          .createUserWithEmailAndPassword(mail: mail, password: password);
      if(user != null){
        final token = await user.getIdToken();
        final AppUser appUser = AppUser(
          avatarUrl: user.photoURL ?? '',
          fcmToken: token,
          fullName: user.displayName ?? '',
          isUserLoggedIn: true,
          userId: user.uid,
        );
        appCubit.saveSession(
          currentAppUser: appUser,
          refreshToken: user.refreshToken ?? '',
          token: token,
        );
        authenticationCubit.setLoading(LoadStatus.success);
        Get.offAllNamed(RouteConfig.mainScreen);
      }else{
        authenticationCubit.setLoading(LoadStatus.failure);
      }
  }

  void changeUsernameOrEmail({required String usernameOrEmail}) {
    emit(
      state.copyWith(
        usernameOrEmail: usernameOrEmail,
      ),
    );
  }

  void changeEmail({required String email}) {
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void changePassword({required String password}) {
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  void onValidateForm() {
    emit(
      state.copyWith(
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
