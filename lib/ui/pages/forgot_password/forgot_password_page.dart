import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/pages/reset_password/reset_password_page.dart';
import 'package:tasky/ui/widgets/buttons/app_icon_button.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'forgot_password_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ForgotPasswordCubit();
      },
      child: const ForgotPasswordChildPage(),
    );
  }
}

class ForgotPasswordChildPage extends StatefulWidget {
  const ForgotPasswordChildPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordChildPage> createState() =>
      _ForgotPasswordChildPageState();
}

class _ForgotPasswordChildPageState extends State<ForgotPasswordChildPage> {
  late final ForgotPasswordCubit _cubit;
  late final TextEditingController usernameOrEmailController;
  late final TextEditingController verificationController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    usernameOrEmailController = TextEditingController();
    verificationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) =>
          previous.isVerification != current.isVerification ||
          previous.autoValidateMode != current.autoValidateMode,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 20).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.forgot_password_title,
                style: AppTextStyle.secondaryBlackO80S21W600,
              ),
              SizedBox(height: 8.h),
              Text(
                state.isVerification
                    ? S.current.forgot_password_description_1
                    : S.current.forgot_password_description_2,
                style: AppTextStyle.grayO40S15W400,
              ),
              SizedBox(height: 32.h),
              buildTextFormField(
                isVerification: state.isVerification,
                autoValidateMode: state.autoValidateMode,
              ),
              SizedBox(height: 24.h),
              buildRowOption(state.isVerification),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextFormField({
    required bool isVerification,
    required AutovalidateMode autoValidateMode,
  }) {
    return Form(
      key: _formKey,
      autovalidateMode: autoValidateMode,
      child: AppUsernameOrEmailInput(
        textEditingController:
            isVerification ? verificationController : usernameOrEmailController,
        color: AppColors.backgroundTextFieldColor,
        borderRadius: 10,
        autoTrim: true,
        autoValidateMode: autoValidateMode,
        labelText: isVerification
            ? S.current.verification
            : S.current.username_or_email,
        hintText: isVerification
            ? S.current.enter_your_code
            : S.current.enter_your_username_or_email,
        onChanged: (value) {
          isVerification
              ? _cubit.changeCode(code: value)
              : _cubit.changeUsernameOrEmail(usernameOrEmail: value);
        },
        validator: (value) {
          //TODO: Làm thêm validator dành cho trường hợp nhập mã
          return null;
        },
      ),
    );
  }

  Widget buildRowOption(bool isVerification) {
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
            if (isVerification) {
              _verify();
            } else {
              _forgotPassword();
            }
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

  void _forgotPassword() {
    if (!validateAndSave) {
      _cubit.onValidateForm();
    } else {
      _cubit.forgotPassword();
    }
    FocusScope.of(context).unfocus();
  }

  void _verify() {
    // if (!validateAndSave) {
    //   _cubit.onValidateForm();
    // } else {
    //   // _cubit.verify();
    // }
    Get.back(closeOverlays: true);
    AppDialog.showCustomDialog(
      content: const ResetPasswordPage(),
    );
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
