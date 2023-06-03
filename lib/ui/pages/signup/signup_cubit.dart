import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
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
    required String userName,
  }) async {
    authenticationCubit.setLoading(LoadStatus.loading);
    User? user = await appCubit.createUserWithEmailAndPassword(
        mail: mail, password: password, userName: userName);
    if (user != null) {
      await appCubit.saveUserToFirebase(user: user, userName: userName);
      authenticationCubit.setLoading(LoadStatus.success);
      Get.offAllNamed(RouteConfig.homeScreen);
    } else {
      authenticationCubit.setLoading(LoadStatus.failure);
    }
  }

  void changeEmail({required String email}) {
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void changeUsername({required String userName}) {
    emit(
      state.copyWith(
        userName: userName,
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
