import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/utils/auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  Future<void> login({
    required String mail,
    required String password,
    required void Function() onLoginSuccessful,
    required void Function() onLoginFailed,
  }) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      await Auth().signInWithEmailAndPassword(mail: mail, password: password);

      emit(state.copyWith(loadDataStatus: LoadStatus.success));
      onLoginSuccessful();
    } on FirebaseAuthException catch (e) {
      log(e.message ?? '');
      onLoginSuccessful();
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void changeUsernameOrEmail({required String usernameOrEmail}) {
    emit(
      state.copyWith(
        usernameOrEmail: usernameOrEmail,
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
