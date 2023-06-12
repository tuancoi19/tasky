import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';
import 'package:tasky/ui/pages/category/add_category/widgets/category_color_picker.dart';
import 'package:tasky/ui/pages/category/add_category/widgets/navigator_row.dart';
import 'package:tasky/ui/pages/home_screen/home_screen_cubit.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'package:tasky/utils/utils.dart';

import 'add_category_cubit.dart';

class AddCategoryArguments {
  final CategoryEntity? category;
  final Function(CategoryEntity?)? onDone;
  final int? theme;

  AddCategoryArguments({
    this.category,
    this.onDone,
    this.theme,
  });
}

class AddCategoryPage extends StatelessWidget {
  final AddCategoryArguments arguments;

  const AddCategoryPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenCubit>(
          create: (context) => HomeScreenCubit(),
          lazy: false,
        ),
        BlocProvider<AddCategoryCubit>(
          create: (context) => AddCategoryCubit(
            homeScreenCubit: BlocProvider.of(context),
          ),
        ),
      ],
      child: AddCategoryChildPage(arguments: arguments),
    );
  }
}

class AddCategoryChildPage extends StatefulWidget {
  final AddCategoryArguments arguments;

  const AddCategoryChildPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<AddCategoryChildPage> createState() => _AddCategoryChildPageState();
}

class _AddCategoryChildPageState extends State<AddCategoryChildPage> {
  late final AddCategoryCubit _cubit;
  late TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(widget.arguments.category);
    _controller = TextEditingController(text: widget.arguments.category?.title);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<AddCategoryCubit, AddCategoryState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 20).r,
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            autovalidateMode: state.autoValidateMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.arguments.category?.id != null
                      ? S.current.edit_category
                      : S.current.add_new_category,
                  style: AppTextStyle.secondaryBlackO80S21W600,
                ),
                SizedBox(height: 32.h),
                AppInput(
                  textEditingController: _controller,
                  borderRadius: 10,
                  color: AppColors.backgroundTextFieldColor,
                  textFieldFocusedBorder: widget.arguments.theme != null
                      ? Color(widget.arguments.theme!)
                      : (widget.arguments.category != null
                          ? Color(widget.arguments.category?.color ?? 0)
                          : null),
                  hintText: S.current.enter_your_category_name,
                  labelText: S.current.category_name,
                  validator: (value) {
                    return Utils.emptyValidator(
                      value ?? '',
                      message: S.current.enter_your_category_name,
                    );
                  },
                  onChanged: (value) {
                    _cubit.changeName(name: value.trim());
                  },
                ),
                SizedBox(height: 28.h),
                Text(
                  S.current.theme,
                  style: AppTextStyle.blackS15W500,
                ),
                SizedBox(height: 20.h),
                CategoryColorPicker(
                  onTap: (value) {
                    _cubit.changeSelectedColor(selectedColor: value);
                  },
                  selectedColor: state.selectedColor,
                  theme: widget.arguments.theme != null
                      ? Color(widget.arguments.theme!)
                      : (widget.arguments.category != null
                          ? Color(widget.arguments.category?.color ?? 0)
                          : null),
                ),
                SizedBox(height: 24.h),
                NavigatorRow(
                  theme: widget.arguments.theme != null
                      ? Color(widget.arguments.theme!)
                      : (widget.arguments.category != null
                          ? Color(widget.arguments.category?.color ?? 0)
                          : null),
                  onPressed: () async {
                    if (state.selectedColor == null) {
                      AppSnackbar.showError(
                        title: S.current.theme,
                        message: S.current.please_choose_a_theme,
                      );
                    }
                    if (_formKey.currentState!.validate() &&
                        state.selectedColor != null) {
                      CategoryEntity? result;
                      if (widget.arguments.category != null) {
                        result = await _cubit.updateCategoryOnFirebase(
                          widget.arguments.category!,
                        );
                      } else {
                        result = await _cubit.addCategoryToFirebase();
                      }
                      Get.back();
                      AppSnackbar.showSuccess(
                        title: S.current.category,
                        message: S.current.success,
                      );
                      widget.arguments.onDone!(result);
                    }
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
    super.dispose();
  }
}
