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
      await appCubit.signInWithEmailAndPassword(mail: mail, password: password);
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user == null) {
        authenticationCubit.setLoading(LoadStatus.success);
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
      Get.offAllNamed(RouteConfig.mainScreen);
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
