import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/pages/authentication/authentication_cubit.dart';
import 'package:tasky/utils/logger.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authenticationCubit,
    required this.appCubit,
  }) : super(const LoginState());
  final AuthenticationCubit authenticationCubit;
  final AppCubit appCubit;

  Future<void> login({
    required String mail,
    required String password,
    required void Function() onLoginSuccessful,
    required void Function(String errorMessage) onLoginFailed,
  }) async {
    authenticationCubit.setLoading(LoadStatus.loading);
    try {
      await appCubit.signInWithEmailAndPassword(mail: mail, password: password);
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user == null) {
        authenticationCubit.setLoading(LoadStatus.success);
        onLoginFailed('Something wrong');
        return;
      }
      final token = await user.getIdToken();

      final appUser = AppUser(
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

      onLoginSuccessful();
    } on FirebaseAuthException catch (e) {
      logger.e(e.message ?? '');
      onLoginFailed(e.message ?? 'Something wrong');
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
