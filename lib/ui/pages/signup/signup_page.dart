import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/authentication/authentication_cubit.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'package:tasky/ui/widgets/input/app_password_input.dart';
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
        final AuthenticationCubit authenticationCubit =
            BlocProvider.of<AuthenticationCubit>(context);
        return SignupCubit(authenticationCubit: authenticationCubit);
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
  late TextEditingController confirmPasswordTextController;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  late ObscureTextController obscurePasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    confirmPasswordTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    obscurePasswordController = ObscureTextController();
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
            onPressed: () {
              _signUp();
            },
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
                  textEditingController: emailTextController,
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
                AppUsernameOrEmailInput(
                  textEditingController: passwordTextController,
                  labelText: S.current.password,
                  hintText: S.current.enter_your_password,
                  borderRadius: 10,
                  autoTrim: true,
                  autoValidateMode: state.autoValidateMode,
                  onChanged: (value) {
                    _cubit.changeEmail(email: value);
                  },
                  // validator: (email) {
                  //   return Utils.emailValidator(email ?? '');
                  // },
                ),
                SizedBox(height: 24.h),
                AppPasswordInput(
                  borderRadius: 10,
                  labelText: S.current.confirm_password,
                  textEditingController: confirmPasswordTextController,
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
        });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  bool get validateAndSave {
    final form = _formKey.currentState ?? FormState();
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();
    _cubit.signUp(
        mail: emailTextController.text,
        password: passwordTextController.text,
        onLoginSuccessful: () {
          print('SignUp susses');
          //save Token noti and push
          //Get.offAllNamed(RouteConfig.dashboard);
        },
        onLoginFailed: () {});
  }
}
