import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/ui/pages/category/category_detail/widgets/category_navigator_header.dart';
import 'package:tasky/ui/pages/category/category_detail/widgets/task_list_view.dart';
import 'package:tasky/ui/widgets/app_detail_page.dart';

import 'category_detail_cubit.dart';

class CategoryDetailArguments {
  final CategoryEntity category;

  CategoryDetailArguments({
    required this.category,
  });
}

class CategoryDetailPage extends StatelessWidget {
  final CategoryDetailArguments arguments;

  const CategoryDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CategoryDetailCubit();
      },
      child: CategoryDetailChildPage(arguments: arguments),
    );
  }
}

class CategoryDetailChildPage extends StatefulWidget {
  final CategoryDetailArguments arguments;

  const CategoryDetailChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<CategoryDetailChildPage> createState() =>
      _CategoryDetailChildPageState();
}

class _CategoryDetailChildPageState extends State<CategoryDetailChildPage> {
  late final CategoryDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
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
    return BlocBuilder<CategoryDetailCubit, CategoryDetailState>(
      builder: (context, state) {
        return AppDetailPage(
          headerWidget: buildFormAddTaskHeader(),
          bodyWidget: buildFormAddTaskBody(),
          headerColor: Colors.amber,
        );
      },
    );
  }

  Widget buildFormAddTaskHeader() {
    return Padding(
      padding: const EdgeInsets.all(28).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryNavigatorHeader(
            onDelete: () {},
            isLoading: false,
            theme: Colors.amber,
            onEdit: () {},
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    '',
                    style: AppTextStyle.whiteS23W500,
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '0',
                      style: AppTextStyle.whiteS26Bold,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      S.current.tasks,
                      style: AppTextStyle.whiteO60S14W500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFormAddTaskBody() {
    return TaskListView(taskList: []);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
