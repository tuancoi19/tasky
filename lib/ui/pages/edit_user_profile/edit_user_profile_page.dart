import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/widgets/appbar/app_bar_with_back_icon_widget.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'package:tasky/ui/widgets/input/app_password_input.dart';
import 'package:tasky/ui/widgets/pickers/app_image_picker.dart';
import 'package:tasky/utils/utils.dart';

import 'edit_user_profile_cubit.dart';

class EditUserProfileArguments {
  bool fromSignUp;
  String username;
  String email;

  EditUserProfileArguments({
    required this.fromSignUp,
    this.username = 'Username',
    this.email = 'Email',
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
        return EditUserProfileCubit();
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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController displayNameController;
  late ObscureTextController obscurePasswordController;
  late TextEditingController passwordTextController;
  late TextEditingController usernameTextController;
  late TextEditingController emailTextController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    displayNameController = TextEditingController();
    obscurePasswordController = ObscureTextController();
    passwordTextController = TextEditingController();
    usernameTextController =
        TextEditingController(text: widget.arguments.username);
    emailTextController = TextEditingController(text: widget.arguments.email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !widget.arguments.fromSignUp;
      },
      child: Scaffold(
        appBar: widget.arguments.fromSignUp
            ? null
            : const AppBarWithBackIconWidget(),
        body: SafeArea(
          child: _buildBodyWidget(),
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
                  InkWell(
                    onTap: () {
                      AppDialog.showCustomBottomSheet(
                        context,
                        widget: SelectUploadImage(
                          onSubmitImage: (value) {
                            return _cubit.setImagePath(imagePath: value.path);
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 84.h,
                      height: 84.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9).r,
                      ),
                      child: Image.asset(
                        AppImages.icUser,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Loren Ipsum', style: AppTextStyle.blackS17W600),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppVectors.icVip,
                        width: 20.w,
                        height: 12.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        S.current.vip_user,
                        style: AppTextStyle.primaryS14W400,
                      )
                    ],
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

  Widget buildInfoColumn(AutovalidateMode autoValidateMode) {
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
          AppInput(
            textEditingController: displayNameController,
            color: AppColors.backgroundTextFieldColor,
            borderRadius: 10,
            autoTrim: true,
            autoValidateMode: autoValidateMode,
            labelText: S.current.display_name,
            hintText: S.current.enter_your_display_name,
            onChanged: (value) {
              _cubit.changeDisplayName(displayName: value);
            },
            validator: (value) {
              return Utils.nameInvalid(value ?? '');
            },
          ),
          SizedBox(height: 32.h),
          AppInput(
            textEditingController: usernameTextController,
            color: AppColors.backgroundTextFieldColor,
            borderRadius: 10,
            labelText: S.current.username,
            readOnly: true,
            textFieldFocusedBorder: Colors.transparent,
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
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    passwordTextController.dispose();
    displayNameController.dispose();
    obscurePasswordController.dispose();
    super.dispose();
  }

  void _save() {
    if (!validateAndSave) {
      _cubit.onValidateForm();
    } else {
      // _cubit.save();
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
