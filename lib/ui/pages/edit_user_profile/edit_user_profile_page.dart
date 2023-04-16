import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_images.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/commons/app_dialog.dart';
import 'package:tasky/ui/widgets/appbar/app_bar_widget.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'package:tasky/ui/widgets/pickers/app_image_picker.dart';
import 'package:tasky/utils/utils.dart';

import 'edit_user_profile_cubit.dart';

class EditUserProfileArguments {
  String param;

  EditUserProfileArguments({
    required this.param,
  });
}

class EditUserProfilePage extends StatelessWidget {
  const EditUserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EditUserProfileCubit();
      },
      child: const EditUserProfileChildPage(),
    );
  }
}

class EditUserProfileChildPage extends StatefulWidget {
  const EditUserProfileChildPage({Key? key}) : super(key: key);

  @override
  State<EditUserProfileChildPage> createState() =>
      _EditUserProfileChildPageState();
}

class _EditUserProfileChildPageState extends State<EditUserProfileChildPage> {
  late final EditUserProfileCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    lastNameController = TextEditingController();
    firstNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(showBackButton: true),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<EditUserProfileCubit, EditUserProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56).r,
          child: Form(
            key: _formKey,
            autovalidateMode: state.autoValidateMode,
            child: Column(
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      AppDialog.showCustomBottomSheet(
                        context,
                        widget: const SelectUploadImage(),
                      );
                    },
                    child: ClipOval(
                      child: Image.asset(
                        AppImages.icUser,
                        fit: BoxFit.cover,
                        width: 60.w,
                        height: 60.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                AppInput(
                  textEditingController: lastNameController,
                  color: AppColors.backgroundTextFieldColor,
                  borderRadius: 10,
                  autoTrim: true,
                  autoValidateMode: state.autoValidateMode,
                  labelText: S.current.last_name,
                  hintText: S.current.enter_your_last_name,
                  onChanged: (value) {
                    _cubit.changeLastName(lastName: value);
                  },
                  validator: (value) {
                    return Utils.nameInvalid(value ?? '');
                  },
                ),
                SizedBox(height: 24.h),
                AppInput(
                  textEditingController: firstNameController,
                  color: AppColors.backgroundTextFieldColor,
                  borderRadius: 10,
                  autoTrim: true,
                  autoValidateMode: state.autoValidateMode,
                  labelText: S.current.first_name,
                  hintText: S.current.enter_your_first_name,
                  onChanged: (value) {
                    _cubit.changeFirstName(firstName: value);
                  },
                  validator: (value) {
                    return Utils.nameInvalid(value ?? '');
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
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    firstNameController.dispose();
    lastNameController.dispose();
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
