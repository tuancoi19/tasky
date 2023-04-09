import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_icon_button.dart';
import 'package:tasky/ui/widgets/input/app_password_input.dart';
import 'package:tasky/utils/utils.dart';

import 'reset_password_cubit.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ResetPasswordCubit();
      },
      child: const ResetPasswordChildPage(),
    );
  }
}

class ResetPasswordChildPage extends StatefulWidget {
  const ResetPasswordChildPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordChildPage> createState() => _ResetPasswordChildPageState();
}

class _ResetPasswordChildPageState extends State<ResetPasswordChildPage> {
  late final ResetPasswordCubit _cubit;
  late final TextEditingController newPasswordController;
  late final TextEditingController repeatPasswordController;
  late ObscureTextController obscureNewPasswordController;
  late ObscureTextController obscureRepeatPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    newPasswordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    obscureNewPasswordController = ObscureTextController();
    obscureRepeatPasswordController = ObscureTextController();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 20).r,
        child: Form(
          key: _formKey,
          autovalidateMode: state.autoValidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPasswordInput(
                borderRadius: 10,
                color: AppColors.backgroundTextFieldColor,
                labelText: S.current.new_password,
                textEditingController: newPasswordController,
                obscureTextController: obscureNewPasswordController,
                hintText: S.current.enter_your_new_password,
                autoTrim: true,
                autoValidateMode: state.autoValidateMode,
                validator: (password) {
                  return Utils.newPasswordValidator(
                    password ?? '',
                    'Đoạn này làm thế nào lấy được mật khẩu cũ để so sánh',
                  );
                },
                onChanged: (value) {
                  _cubit.changeNewPassword(newPassword: value);
                },
              ),
              SizedBox(height: 28.h),
              AppPasswordInput(
                borderRadius: 10,
                color: AppColors.backgroundTextFieldColor,
                labelText: S.current.repeat_password,
                textEditingController: repeatPasswordController,
                obscureTextController: obscureRepeatPasswordController,
                hintText: S.current.enter_your_new_password,
                autoTrim: true,
                autoValidateMode: state.autoValidateMode,
                validator: (password) {
                  return Utils.newPasswordValidator(
                      password ?? '', state.newPassword ?? '');
                },
                onChanged: (value) {
                  _cubit.changeNewPassword(newPassword: value);
                },
              ),
              SizedBox(height: 28.h),
              buildRowOption(),
            ],
          ),
        ),
      );
    });
  }

  Widget buildRowOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Get.back(closeOverlays: true);
          },
          child: Text(
            S.current.close,
            style: AppTextStyle.primaryO50S14W400,
          ),
        ),
        AppIconButton(
          onPressed: () {
            _resetPassword();
          },
          backgroundColor: AppColors.primary,
          cornerRadius: 10,
          width: 48,
          height: 48,
          icon: SvgPicture.asset(
            AppVectors.icArrowRight,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _resetPassword() {
    if (!validateAndSave) {
      _cubit.onValidateForm();
    } else {
      // _cubit.resetPassword();
    }
    FocusScope.of(context).unfocus();
  }

  bool get validateAndSave {
    final form = _formKey.currentState ?? FormState();
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
