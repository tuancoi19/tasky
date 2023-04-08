import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/ui/widgets/input/app_password_input.dart';
import 'package:tasky/ui/widgets/input/app_username_or_email.dart';
import 'package:tasky/utils/utils.dart';

import 'signup_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignupCubit();
      },
      child: const SigninChildPage(),
    );
  }
}

class SigninChildPage extends StatefulWidget {
  const SigninChildPage({Key? key}) : super(key: key);

  @override
  State<SigninChildPage> createState() => _SigninChildPageState();
}

class _SigninChildPageState extends State<SigninChildPage> {
  late final SignupCubit _cubit;
  late TextEditingController usernameOrEmailTextController;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late ObscureTextController obscurePasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    usernameOrEmailTextController = TextEditingController();
    emailTextController = TextEditingController();
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
          SizedBox(height: 44.h),
          AppButton(
            height: 56.h,
            title: S.current.log_in,
            cornerRadius: 15.r,
            textStyle: AppTextStyle.whiteS18Bold,
            backgroundColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return BlocBuilder<SignupCubit, SignupState>(
        buildWhen: (previous, current) =>
            previous.autoValidateMode != current.autoValidateMode,
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidateMode: state.autoValidateMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppUsernameOrEmailInput(
                  textEditingController: usernameOrEmailTextController,
                  labelText: S.current.username_or_email,
                  hintText: S.current.enter_your_username_or_email,
                  borderRadius: 10,
                  onChanged: (value) {
                    _cubit.changeUsernameOrEmail(usernameOrEmail: value);
                  },
                ),
                SizedBox(height: 24.h),
                AppUsernameOrEmailInput(
                  textEditingController: emailTextController,
                  labelText: S.current.email,
                  hintText: S.current.enter_your_email,
                  borderRadius: 10,
                  onChanged: (value) {
                    _cubit.changeEmail(email: value);
                  },
                  validator: (email) {
                    return Utils.emailValidator(email ?? '');
                  },
                ),
                SizedBox(height: 24.h),
                AppPasswordInput(
                  borderRadius: 10,
                  labelText: S.current.password,
                  textEditingController: passwordTextController,
                  obscureTextController: obscurePasswordController,
                  hintText: S.current.enter_your_password,
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
        });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
