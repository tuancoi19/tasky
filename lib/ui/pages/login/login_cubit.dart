import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/router/route_config.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/pages/authentication/authentication_cubit.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
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
  }) async {
    authenticationCubit.setLoading(LoadStatus.loading);
    try {
      final User? user = await appCubit.logInWithEmailAndPassword(
          mail: mail, password: password);
      if (user == null) {
        authenticationCubit.setLoading(LoadStatus.failure);
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
      await appCubit.saveSession(
        currentAppUser: appUser,
        refreshToken: user.refreshToken ?? '',
        token: token,
      );
      authenticationCubit.setLoading(LoadStatus.success);
      Get.offAllNamed(RouteConfig.homeScreen);
    } on FirebaseAuthException catch (e) {
      logger.e(e.message ?? '');
      AppDialog.showCustomDialog(
        content: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.login_failed,
                style: AppTextStyle.secondaryBlackO80S21W600,
              ),
              SizedBox(height: 8.h),
              Text(
                e.message ?? 'Something wrong',
                style: AppTextStyle.grayO40S15W400,
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
      authenticationCubit.setLoading(LoadStatus.failure);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    appCubit.forgotPassword(email: email);
  }

  void changeEmail({required String email}) {
    emit(
      state.copyWith(
        usernameOrEmail: email,
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
