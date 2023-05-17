import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/app_time_picker.dart';
import 'package:tasky/ui/widgets/appbar/app_bar_with_back_icon_widget.dart';
import 'package:tasky/ui/widgets/input/app_input.dart';

import 'task_information_cubit.dart';

// class TaskInformationArguments {
//   String param;
//
//   TaskInformationArguments({
//     required this.param,
//   });
// }

class TaskInformationPage extends StatelessWidget {
  // final TaskInformationArguments arguments;

  const TaskInformationPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TaskInformationCubit();
      },
      child: const TaskInformationChildPage(),
    );
  }
}

class TaskInformationChildPage extends StatefulWidget {
  const TaskInformationChildPage({Key? key}) : super(key: key);

  @override
  State<TaskInformationChildPage> createState() =>
      _TaskInformationChildPageState();
}

class _TaskInformationChildPageState extends State<TaskInformationChildPage> {
  late final TaskInformationCubit _cubit;
  late TextEditingController titleController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    titleController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackIconWidget(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<TaskInformationCubit, TaskInformationState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(24).r,
          child: Form(
            key: _formKey,
            autovalidateMode: state.autoValidateMode,
            child: Column(
              children: [
                AppInput(
                  textEditingController: titleController,
                  labelText: S.current.title,
                  hintText: S.current.please_enter_your_task_title,
                  borderRadius: 10,
                  autoTrim: true,
                  autoValidateMode: state.autoValidateMode,
                  color: AppColors.backgroundBackButtonColor,
                  onChanged: (value) {
                    _cubit.changeTitle(title: value);
                  },
                ),
                SizedBox(height: 32.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: AppTimePicker(
                        title: S.current.start_time,
                        onChange: (value) {
                          _cubit.changeStartTime(startTime: value ?? '');
                        },
                        controller: startTimeController,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Expanded(
                      child: Divider(
                        color: AppColors.primary,
                        thickness: 1,
                        height: 56.h,
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Expanded(
                      child: AppTimePicker(
                        title: S.current.end_time,
                        onChange: (value) {
                          _cubit.changeEndTime(endTime: value ?? '');
                        },
                        controller: endTimeController,
                      ),
                    )
                  ],
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
