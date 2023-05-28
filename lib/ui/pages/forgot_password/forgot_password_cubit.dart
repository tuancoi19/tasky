import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({required this.appCubit})
      : super(const ForgotPasswordState());
  final AppCubit appCubit;

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> forgotPassword() async {
    if (state.email != null) {
      String? requestSendEmail =
          await appCubit.forgotPassword(email: state.email!);
      if (requestSendEmail != null) {
        AppDialog.showCustomDialog(
          content: Padding(
            padding: const EdgeInsets.all(16).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  requestSendEmail ?? '',
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
      } else {
        AppDialog.showCustomDialog(
          content: Padding(
            padding: const EdgeInsets.all(16).r,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.forgot_password_instruction,
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
      }
    } else {
      return;
    }
  }

  void onValidateForm() {
    emit(
      state.copyWith(
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  void changEmail({required String email}) {
    emit(
      state.copyWith(email: email),
    );
  }

  void changeCode({required String code}) {
    emit(
      state.copyWith(code: code),
    );
  }
}
