import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/category/widgets/category_color_picker.dart';
import 'package:tasky/ui/pages/category/widgets/navigator_row.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';
import 'package:tasky/utils/utils.dart';

import 'category_cubit.dart';

class CategoryArguments {
  String? id;

  CategoryArguments({
    this.id,
  });
}

class CategoryPage extends StatelessWidget {
  final CategoryArguments arguments;

  const CategoryPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CategoryCubit();
      },
      child: CategoryChildPage(arguments: arguments),
    );
  }
}

class CategoryChildPage extends StatefulWidget {
  final CategoryArguments arguments;

  const CategoryChildPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<CategoryChildPage> createState() => _CategoryChildPageState();
}

class _CategoryChildPageState extends State<CategoryChildPage> {
  late final CategoryCubit _cubit;
  late TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<CategoryCubit, CategoryState>(
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
                Text(
                  widget.arguments.id != null
                      ? S.current.category_detail
                      : S.current.add_new_category,
                  style: AppTextStyle.secondaryBlackO80S21W600,
                ),
                SizedBox(height: 32.h),
                AppInput(
                  textEditingController: _controller,
                  borderRadius: 10,
                  color: AppColors.backgroundTextFieldColor,
                  hintText: S.current.enter_your_category_name,
                  labelText: S.current.category_name,
                  validator: (value) {
                    return Utils.emptyValidator(
                      value ?? '',
                      message: S.current.enter_your_category_name,
                    );
                  },
                ),
                SizedBox(height: 28.h),
                Text(
                  'Theme',
                  style: AppTextStyle.blackS15W500,
                ),
                SizedBox(height: 20.h),
                CategoryColorPicker(
                  onTap: (value) {
                    _cubit.changeSelectedColor(selectedColor: value);
                  },
                  selectedColor: state.selectedColor,
                ),
                SizedBox(height: 24.h),
                NavigatorRow(
                  onPressed: () {},
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
