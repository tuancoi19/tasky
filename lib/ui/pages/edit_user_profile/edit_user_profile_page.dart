import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/appbar/app_bar_with_back_icon_widget.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'package:tasky/ui/widgets/input/app_password_input.dart';
import 'package:tasky/utils/utils.dart';

import 'edit_user_profile_cubit.dart';

class EditUserProfileArguments {
  bool fromSignUp;

  EditUserProfileArguments({
    required this.fromSignUp,
  });
}

class EditUserProfilePage extends StatelessWidget {
  final EditUserProfileArguments arguments;

  const EditUserProfilePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final AppCubit appCubit = BlocProvider.of<AppCubit>(context);
        return EditUserProfileCubit(appCubit);
      },
      child: EditUserProfileChildPage(
        arguments: arguments,
      ),
    );
  }
}

class EditUserProfileChildPage extends StatefulWidget {
  final EditUserProfileArguments arguments;

  const EditUserProfileChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<EditUserProfileChildPage> createState() =>
      _EditUserProfileChildPageState();
}

class _EditUserProfileChildPageState extends State<EditUserProfileChildPage> {
  late final EditUserProfileCubit _cubit;
  late AppCubit appCubit;
  final _formKey = GlobalKey<FormState>();
  late ObscureTextController obscurePasswordController;
  late TextEditingController passwordTextController;
  late TextEditingController usernameTextController;
  late TextEditingController emailTextController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    appCubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    obscurePasswordController = ObscureTextController();
    passwordTextController = TextEditingController();
    usernameTextController =
        TextEditingController(text: appCubit.state.user?.userName);
    emailTextController =
        TextEditingController(text: appCubit.state.user?.email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !widget.arguments.fromSignUp;
      },
      child: Scaffold(
        appBar:
            AppBarWithBackIconWidget(fromSignUp: widget.arguments.fromSignUp),
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
        floatingActionButton:
            BlocBuilder<EditUserProfileCubit, EditUserProfileState>(
          builder: (context, state) {
            return !state.isEditProfile
                ? FloatingActionButton(
                    onPressed: () {
                      _cubit.setIsEdit(true);
                    },
                    backgroundColor: AppColors.backgroundLight,
                    child: const Icon(
                      Icons.mode_edit_outline_outlined,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<EditUserProfileCubit, EditUserProfileState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            autovalidateMode: state.autoValidateMode,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 8).r,
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildAvatar(),
                  SizedBox(height: 16.h),
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      return Text(
                        state.user?.userName ?? '',
                        style: AppTextStyle.blackS17W600,
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                  buildInfoColumn(state.autoValidateMode),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 55.h,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            AppImages.icUser,
            width: 110.h,
            height: 110.h,
            fit: BoxFit.cover,
          ),
        ),
        _cubit.state.isEditProfile
            ? Container(
                width: 115.h,
                height: 115.h,
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet'),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 18.h,
                    backgroundColor: Colors.white38.withOpacity(0.8),
                    // color: Colors.red,
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 25,
                      color: AppColors.iconAddImage,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget buildInfoColumn(AutovalidateMode autoValidateMode) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(24).r,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 50.r,
                color: AppColors.boxShadowColor.withOpacity(0.27),
                blurStyle: BlurStyle.outer,
              ),
            ],
            borderRadius: BorderRadius.vertical(
              top: const Radius.circular(30).r,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              AppInput(
                textEditingController: usernameTextController,
                color: AppColors.backgroundTextFieldColor,
                borderRadius: 10,
                labelText: S.current.username,
                readOnly: !_cubit.state.isEditProfile,
                textFieldFocusedBorder: Colors.transparent,
                onChanged: (value) {
                  _cubit.changeUserName(userName: value);
                },
              ),
              SizedBox(height: 32.h),
              AppInput(
                textEditingController: emailTextController,
                color: AppColors.backgroundTextFieldColor,
                borderRadius: 10,
                labelText: S.current.email,
                readOnly: true,
                textFieldFocusedBorder: Colors.transparent,
              ),
              SizedBox(height: 32.h),
              if (!widget.arguments.fromSignUp)
                AppPasswordInput(
                  obscureTextController: obscurePasswordController,
                  textEditingController: passwordTextController,
                  color: AppColors.backgroundTextFieldColor,
                  borderRadius: 10,
                  autoTrim: true,
                  autoValidateMode: autoValidateMode,
                  labelText: S.current.password,
                  hintText: S.current.enter_your_password,
                  onChanged: (value) {
                    _cubit.changePassword(password: value);
                  },
                  validator: (password) {
                    return Utils.currentPasswordValidator(password ?? '');
                  },
                ),
              SizedBox(height: 32.h),
              BlocBuilder<EditUserProfileCubit, EditUserProfileState>(
                builder: (context, state) {
                  if (state.isEditProfile) {
                    return Column(
                      children: [
                        AppButton(
                          height: 56.h,
                          cornerRadius: 10,
                          title: S.current.done,
                          backgroundColor: AppColors.primary,
                          textStyle: AppTextStyle.whiteS18Bold,
                          onPressed: () {
                            _save();
                          },
                        ),
                        const SizedBox(height: 20),
                        AppButton(
                          height: 56.h,
                          cornerRadius: 10,
                          title: S.current.cancel,
                          backgroundColor: AppColors.welcomeBackgroundColor,
                          textStyle: AppTextStyle.whiteS18Bold,
                          onPressed: () {
                            _cubit.setIsEdit(false);
                            usernameTextController.value = TextEditingValue(
                                text: appCubit.state.user?.userName ?? '');
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    passwordTextController.dispose();
    obscurePasswordController.dispose();
    super.dispose();
  }

  void _save() {
    if (!validateAndSave) {
      _cubit.onValidateForm();
    } else {
      // _cubit.save();
      _cubit.setIsEdit(false);
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
