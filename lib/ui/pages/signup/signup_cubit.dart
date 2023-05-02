import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/pages/authentication/authentication_cubit.dart';
import 'package:tasky/utils/auth.dart';
import 'package:tasky/utils/logger.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({
    required this.authenticationCubit,
  }) : super(const SignupState());

  final AuthenticationCubit authenticationCubit;

  Future<void> signUp({
    required String mail,
    required String password,
    required void Function() onLoginSuccessful,
    required void Function() onLoginFailed,
  }) async {
    authenticationCubit.setLoading(LoadStatus.loading);
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      await Auth()
          .createUserWithEmailAndPassword(mail: mail, password: password);
      authenticationCubit.setLoading(LoadStatus.success);
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
      onLoginSuccessful();
    } on FirebaseAuthException catch (e) {
      logger.e(e.message ?? '');
      onLoginFailed();
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
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
