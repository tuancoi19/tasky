import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_category_list.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_date_picker.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_duration_picker.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_title_text_form_field.dart';
import 'package:tasky/ui/pages/task_screen/widgets/task_upload_documents.dart';
import 'package:tasky/ui/pages/task_screen/widgets/note_text_field.dart';
import 'package:tasky/ui/widgets/app_task_page.dart';
import 'package:tasky/ui/widgets/buttons/app_button.dart';

import 'task_screen_cubit.dart';

// class TaskScreenArguments {
//   String param;
//
//   TaskScreenArguments({
//     required this.param,
//   });
// }

class TaskScreenPage extends StatelessWidget {
  // final TaskScreenArguments arguments;

  const TaskScreenPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TaskScreenCubit();
      },
      child: const TaskScreenChildPage(),
    );
  }
}

class TaskScreenChildPage extends StatefulWidget {
  const TaskScreenChildPage({Key? key}) : super(key: key);

  @override
  State<TaskScreenChildPage> createState() => _TaskScreenChildPageState();
}

class _TaskScreenChildPageState extends State<TaskScreenChildPage> {
  late final TaskScreenCubit _cubit;
  late TextEditingController titleController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController dateController;
  late TextEditingController noteController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    titleController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    dateController = TextEditingController();
    noteController = TextEditingController();
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
        return Form(
          key: _formKey,
          autovalidateMode: state.autoValidateMode,
          child: AppTaskPage(
            headerWidget: buildFormAddTaskHeader(dateHintText: state.date),
            bodyWidget: buildFormAddTaskBody(),
            bodyHeight: 564.h,
            headerColor: state.themeColor,
          ),
        );
      },
    );
  }

  Widget buildFormAddTaskHeader({required String? dateHintText}) {
    return Padding(
      padding: const EdgeInsets.all(28).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(
              AppVectors.icArrowLeft,
              width: 20.h,
              height: 16.h,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
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
                  onChanged: (value) {
                    _cubit.changeTitle(title: value);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TaskDatePicker(
                  controller: dateController,
                  whenComplete: (value) {
                    _cubit.changeDate(date: value);
                  },
                  hintText: dateHintText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFormAddTaskBody() {
    return BlocBuilder<TaskScreenCubit, TaskScreenState>(
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 32,
              ).r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TaskDurationPicker(
                    startTimeOnChange: (value) {
                      _cubit.changeStartTime(startTime: value ?? '');
                    },
                    endTimeOnChange: (value) {
                      _cubit.changeEndTime(endTime: value ?? '');
                    },
                    startTimeController: startTimeController,
                    endTimeController: endTimeController,
                    color: state.themeColor,
                  ),
                  SizedBox(height: 32.h),
                  NoteTextField(
                    onChanged: (value) {
                      _cubit.changeNote(note: value);
                    },
                    controller: noteController,
                    color: state.themeColor,
                  ),
                  SizedBox(height: 32.h),
                  TaskCategoryList(
                    listData: state.categoryList ?? [],
                    onSelected: (value) {
                      _cubit.changeCategory(category: value);
                    },
                    selectedCategory: state.category ??
                        CategoryEntity(
                          title: '',
                          color: 0,
                        ),
                  ),
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
                  SizedBox(height: 88.h),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16).r,
                child: AppButton(
                  onPressed: () {},
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

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
