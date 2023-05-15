import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/generated/l10n.dart';
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
  final ref = FirebaseDatabase.instance.ref().child('users');

  Future<void> signUp({
    required String mail,
    required String password,
    required String userName,
    required void Function() onSignUpSuccessful,
    required void Function(String errorMessage) onSignUpFailed,
  }) async {
    authenticationCubit.setLoading(LoadStatus.loading);

    try {
      final user = await Auth()
          .createUserWithEmailAndPassword(mail: mail, password: password);
      if (user.user == null) {
        authenticationCubit.setLoading(LoadStatus.success);
        onSignUpFailed(S.current.sign_up_failed);
        return;
      }
      final userDefaultInfo = user.user;
      ref.child((userDefaultInfo?.uid ?? '').toString()).set({
        'uid': userDefaultInfo?.uid ?? '',
        'email': userDefaultInfo?.email ?? '',
        'image': '',
        'userName': 'userName',
      }).then((value) {
        authenticationCubit.setLoading(LoadStatus.success);
      }).onError((error, stackTrace) {
        authenticationCubit.setLoading(LoadStatus.success);
        onSignUpFailed(error.toString());
      });
      onSignUpSuccessful();
    } on FirebaseAuthException catch (e) {
      logger.e(e.message ?? '');
      onSignUpFailed(e.message ?? '');
      authenticationCubit.setLoading(LoadStatus.success);
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
