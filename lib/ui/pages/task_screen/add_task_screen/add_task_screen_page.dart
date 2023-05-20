import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/app_schedule.dart';
import 'package:tasky/ui/widgets/app_task_page.dart';

import 'add_task_screen_cubit.dart';

// class AddTaskScreenArguments {
//   String param;
//
//   AddTaskScreenArguments({
//     required this.param,
//   });
// }

class AddTaskScreenPage extends StatelessWidget {
  // final AddTaskScreenArguments arguments;

  const AddTaskScreenPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AddTaskScreenCubit();
      },
      child: const AddTaskScreenChildPage(),
    );
  }
}

class AddTaskScreenChildPage extends StatefulWidget {
  const AddTaskScreenChildPage({Key? key}) : super(key: key);

  @override
  State<AddTaskScreenChildPage> createState() => _AddTaskScreenChildPageState();
}

class _AddTaskScreenChildPageState extends State<AddTaskScreenChildPage> {
  late final AddTaskScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return AppTaskPage(
      headerWidget: buildFormAddTaskHeader(),
      bodyWidget: const AppSchedule(),
      bodyHeight: 368.h,
    );
  }

  Widget buildFormAddTaskHeader() {
    return Container(
      padding: const EdgeInsets.all(28).r,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              AppVectors.icPlus,
              width: 20.h,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(height: 28.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  maxLines: 2,
                  style: AppTextStyle.whiteS23W500,
                  decoration: InputDecoration(
                    hintText: S.current.type_your_title,
                    hintStyle: AppTextStyle.whiteO90S23W500,
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16).r,
                child: Text(
                  '11 Dec, 2020',
                  style: AppTextStyle.whiteO60S14W500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
