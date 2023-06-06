import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/ui/pages/home_screen/home_screen_cubit.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_category_list.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_date_picker.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_duration_picker.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_navigator_header.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_title_text_form_field.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_upload_documents.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_take_note_text_field.dart';
import 'package:tasky/ui/widgets/app_task_page.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

import 'task_screen_cubit.dart';

class TaskScreenArguments {
  final TaskEntity task;

  TaskScreenArguments({
    required this.task,
  });
}

class TaskScreenPage extends StatelessWidget {
  final TaskScreenArguments? arguments;

  const TaskScreenPage({
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
        BlocProvider<TaskScreenCubit>(
          create: (context) => TaskScreenCubit(
            homeScreenCubit: BlocProvider.of(context),
          ),
        ),
      ],
      child: TaskScreenChildPage(
        arguments: arguments,
      ),
    );
  }
}

class TaskScreenChildPage extends StatefulWidget {
  final TaskScreenArguments? arguments;

  const TaskScreenChildPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<TaskScreenChildPage> createState() => _TaskScreenChildPageState();
}

class _TaskScreenChildPageState extends State<TaskScreenChildPage> {
  late final TaskScreenCubit _cubit;
  late TextEditingController titleController;
  late TextEditingController noteController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData(widget.arguments?.task);
    titleController =
        TextEditingController(text: widget.arguments?.task.title ?? '');
    noteController =
        TextEditingController(text: widget.arguments?.task.note ?? '');
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
    return BlocBuilder<TaskScreenCubit, TaskScreenState>(
      builder: (context, state) {
        return Stack(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: state.autoValidateMode,
              child: AppTaskPage(
                headerWidget: buildFormAddTaskHeader(),
                bodyWidget: buildFormAddTaskBody(),
                bodyHeight: 564.h,
                headerColor: state.themeColor,
              ),
            ),
            if (state.isEdit || widget.arguments?.task == null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
                          .r,
                  child: AppButton(
                    onPressed: () async {
                      _cubit.setAutoValidateMode(
                        autoValidateMode: AutovalidateMode.always,
                      );
                      if (_formKey.currentState!.validate()) {
                        await _cubit.onDone();
                      }
                    },
                    isLoading: state.isLoading,
                    title: S.current.done,
                    height: 56.h,
                    textStyle: AppTextStyle.whiteS18Bold,
                    backgroundColor: state.themeColor,
                    cornerRadius: 15.r,
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  Widget buildFormAddTaskHeader() {
    return BlocBuilder<TaskScreenCubit, TaskScreenState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(28).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskNavigatorHeader(
                isEdit: state.isEdit,
                onChangeIsEdit: () {
                  _cubit.setIsEdit();
                  if (!state.isEdit) {
                    _cubit.loadInitialData(widget.arguments?.task);
                  }
                },
                onDelete: () {},
                isShowOptions: widget.arguments?.task != null && !state.isEdit,
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TaskTitleTextFormField(
                      controller: titleController,
                      onChanged: (value) async {
                        await _cubit.changeTitle(title: value);
                      },
                      readOnly: widget.arguments?.task != null && !state.isEdit,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TaskDatePicker(
                      whenComplete: (value) {
                        _cubit.changeDate(date: value);
                      },
                      hintDate: state.date,
                      themeColor: state.themeColor,
                      readOnly: widget.arguments?.task != null && !state.isEdit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildFormAddTaskBody() {
    return BlocBuilder<TaskScreenCubit, TaskScreenState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AbsorbPointer(
                absorbing: widget.arguments?.task != null && !state.isEdit,
                child: TaskDurationPicker(
                  startTimeOnChange: (value) {
                    _cubit.changeStartTime(startTime: value);
                  },
                  endTimeOnChange: (value) {
                    _cubit.changeEndTime(endTime: value);
                  },
                  color: state.themeColor,
                  hintStartTime: state.startTime,
                  hintEndTime: state.endTime,
                ),
              ),
              SizedBox(height: 32.h),
              TaskTakeNoteTextField(
                onChanged: (value) async {
                  await _cubit.changeNote(note: value);
                },
                controller: noteController,
                color: state.themeColor,
                readOnly: widget.arguments?.task != null && !state.isEdit,
              ),
              SizedBox(height: 32.h),
              AbsorbPointer(
                absorbing: widget.arguments?.task != null && !state.isEdit,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TaskCategoryList(
                        listData: state.categoryList ?? [],
                        onSelected: (value) {
                          _cubit.changeCategory(category: value);
                        },
                        selectedCategory: state.category,
                        onDone: (value) {
                          if (value != null) {
                            _cubit.changeCategory(category: value);
                            _cubit.fetchCategoryList();
                          }
                        }),
                    SizedBox(height: 32.h),
                    Flexible(
                      fit: FlexFit.loose,
                      child: TaskUploadDocuments(
                        documentList: state.documentList ?? [],
                        onDelete: (value) {
                          _cubit.changeDocumentList(documentList: value);
                        },
                        sendImage: (value) {
                          _cubit.sendImage(file: value);
                        },
                        sendTextFile: (value) {
                          _cubit.sendTextFile(file: value);
                        },
                        buttonColor: state.themeColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 88.h),
            ],
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
