import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:tasky/ui/pages/login/widgets/option_list_widget.dart';
import 'package:tasky/ui/pages/login/widgets/option_title.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/ui/widgets/input/app_password_input.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'package:tasky/utils/utils.dart';

import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: const LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({Key? key}) : super(key: key);

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  late final LoginCubit _cubit;
  late TextEditingController usernameOrEmailTextController;
  late TextEditingController passwordTextController;
  late ObscureTextController obscurePasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    usernameOrEmailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    obscurePasswordController = ObscureTextController();
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      color: AppColors.authBackgroundColor,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 24).r,
        children: [
          buildForm(),
          SizedBox(height: 32.h),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                AppDialog.showCustomDialog(
                  content: const ForgotPasswordPage(),
                );
              },
              child: Text(
                S.current.forgot_password,
                style: AppTextStyle.blackO80S14W400,
              ),
            ),
          ),
          SizedBox(height: 32.h),
          AppButton(
            height: 56.h,
            title: S.current.log_in,
            cornerRadius: 15.r,
            textStyle: AppTextStyle.whiteS18Bold,
            backgroundColor: AppColors.primary,
            onPressed: () {
              _logIn();
            },
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56).r,
            child: const OptionTitle(),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56).r,
            child: const OptionListWidget(),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.autoValidateMode != current.autoValidateMode,
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode: state.autoValidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppInput(
                textEditingController: usernameOrEmailTextController,
                labelText: S.current.username_or_email,
                hintText: S.current.enter_your_username_or_email,
                borderRadius: 10,
                autoTrim: true,
                autoValidateMode: state.autoValidateMode,
                onChanged: (value) {
                  _cubit.changeUsernameOrEmail(usernameOrEmail: value);
                },
              ),
              SizedBox(height: 24.h),
              AppPasswordInput(
                borderRadius: 10,
                labelText: S.current.password,
                textEditingController: passwordTextController,
                obscureTextController: obscurePasswordController,
                hintText: S.current.enter_your_password,
                autoTrim: true,
                autoValidateMode: state.autoValidateMode,
                validator: (password) {
                  return Utils.currentPasswordValidator(password ?? '');
                },
                onChanged: (value) {
                  _cubit.changePassword(password: value);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    usernameOrEmailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void _logIn() {
    if (!validateAndSave) {
      _cubit.onValidateForm();
    } else {
      // _cubit.logIn();
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
