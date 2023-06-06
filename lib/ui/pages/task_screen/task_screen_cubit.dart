import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';
import 'package:tasky/ui/pages/home_screen/home_screen_cubit.dart';
import 'package:tasky/utils/date_time_utils.dart';
import 'package:tasky/utils/file_utils.dart';
import 'package:tasky/utils/logger.dart';

part 'task_screen_state.dart';

class TaskScreenCubit extends Cubit<TaskScreenState> {
  final HomeScreenCubit homeScreenCubit;

  TaskScreenCubit({
    required this.homeScreenCubit,
  }) : super(const TaskScreenState());

  void loadInitialData(TaskEntity? task) {
    fetchCategoryList();
    changeDate(date: task?.dateFromString ?? DateTime.now());
    changeStartTime(startTime: task?.startFromString ?? TimeOfDay.now());
    changeEndTime(endTime: task?.endFromString ?? TimeOfDay.now());
    changeNote(note: task?.note ?? '');
    changeTitle(title: task?.title ?? '');

    if (task != null) {
      changeCategory(category: task.category!);
      changeThemeColor(colorCode: task.category!.color!);
      changeDocumentList(
        documentList: task.documents!
            .map(
              (e) => FileUtils.getFileNameFromUrl(e),
            )
            .toList(),
      );
    }
  }

  Future<void> changeTitle({required String title}) async {
    emit(state.copyWith(title: title));
    if (title.length == 50) {
      await Fluttertoast.showToast(
        msg: S.current.please_do_not_enter_more_than_characters(50),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void changeStartTime({required TimeOfDay startTime}) {
    emit(state.copyWith(startTime: startTime));
  }

  void changeEndTime({required TimeOfDay endTime}) {
    emit(state.copyWith(endTime: endTime));
  }

  void changeDate({required DateTime date}) {
    emit(state.copyWith(date: date));
  }

  Future<void> changeNote({required String note}) async {
    emit(state.copyWith(note: note));
    if (note.length == 1000) {
      await Fluttertoast.showToast(
        msg: S.current.please_do_not_enter_more_than_characters(1000),
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void fetchCategoryList() {
    emit(state.copyWith(categoryList: GlobalData.instance.categoriesList));
  }

  void changeCategory({required CategoryEntity category}) {
    emit(state.copyWith(category: category));
    changeThemeColor(colorCode: category.color!);
  }

  void changeDocumentList({required List<String> documentList}) {
    emit(state.copyWith(documentList: documentList));
  }

  void sendImage({required File file}) {
    final List<String> addedList = [...?state.documentList];
    addedList.add(file.path);
    changeDocumentList(documentList: addedList);
  }

  void sendTextFile({required File file}) {
    final List<String> addedList = [...?state.documentList];
    addedList.add(file.path);
    changeDocumentList(documentList: addedList);
  }

  void changeThemeColor({required int colorCode}) {
    emit(state.copyWith(themeColor: Color(colorCode)));
  }

  void setAutoValidateMode({required AutovalidateMode autoValidateMode}) {
    emit(state.copyWith(autoValidateMode: autoValidateMode));
  }

  void setIsEdit() {
    emit(state.copyWith(isEdit: !state.isEdit));
  }

  Future<void> onDone(TaskEntity? task) async {
    final bool checkDuration = (state.endTime ?? TimeOfDay.now()).hour >
            (state.startTime ?? TimeOfDay.now()).hour ||
        ((state.endTime ?? TimeOfDay.now()).hour ==
                (state.startTime ?? TimeOfDay.now()).hour &&
            (state.endTime ?? TimeOfDay.now()).minute >=
                (state.startTime ?? TimeOfDay.now()).minute);

    if (DateTimeUtils.isOlderDate(state.date ?? DateTime.now())) {
      AppSnackbar.showError(
        title: S.current.date,
        message: S.current.date_has_passed,
      );
    } else if (DateTimeUtils.isSameDate(state.date ?? DateTime.now()) &&
        !(DateTimeUtils.isTimeOfDayValid(state.startTime ?? TimeOfDay.now()) ||
            DateTimeUtils.isTimeOfDayValid(state.endTime ?? TimeOfDay.now()))) {
      AppSnackbar.showError(
        title: S.current.start_time_end_time,
        message: S.current.this_time_range_has_passed,
      );
    } else if (!checkDuration) {
      AppSnackbar.showError(
        title: S.current.start_time_end_time,
        message: S.current.end_time_cannot_be_chosen_earlier_than_start_time,
      );
    }
    /* else if (DateTimeUtils.isOverlap(
      data: TaskDateUtils.filterItemsByDate(
        items: GlobalData.instance.tasksList,
        date: state.date ?? DateTime.now(),
      ),
      newStartTime: DateTimeUtils.convertTimeOfDayToString(
        state.startTime ?? TimeOfDay.now(),
      ),
      newEndTime: DateTimeUtils.convertTimeOfDayToString(
        state.endTime ?? TimeOfDay.now(),
      ),
    )) {
      AppSnackbar.showError(
        title: 'Start time - End time',
        message: 'There is a task scheduled during this time',
      );
    } */
    else if (state.category == null) {
      AppSnackbar.showError(
        title: S.current.category,
        message: S.current.please_select_a_category_for_this_task,
      );
    } else {
      if (state.isEdit && task != null) {
        await updateTaskToFirebase(task);
      } else {
        await addTaskToFirebase();
      }
    }
  }

  Future<void> updateTaskToFirebase(TaskEntity? initialTask) async {
    emit(state.copyWith(isLoading: true));
    final TaskEntity task = TaskEntity(
      title: state.title?.trim() ?? '',
      note: state.note?.trim() ?? '',
      documents: await uploadFileToStorage(task: initialTask),
      date: DateTimeUtils.convertDateTimeToString(state.date ?? DateTime.now())
          .toString(),
      start: DateTimeUtils.convertTimeOfDayToString(
          state.startTime ?? TimeOfDay.now()),
      end: DateTimeUtils.convertTimeOfDayToString(
          state.endTime ?? TimeOfDay.now()),
      category: state.category ?? CategoryEntity(title: '', color: 0),
    );

    try {
      if (task != initialTask) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(GlobalData.instance.userID)
            .collection('tasks')
            .doc(initialTask?.id)
            .update(task.toJson());
      }
      Get.back(result: true);
      AppSnackbar.showSuccess(
        title: S.current.task,
        message: S.current.updated_successfully,
      );
    } on FirebaseAuthException catch (e) {
      AppSnackbar.showError(title: 'Firebase', message: e.message);
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> addTaskToFirebase() async {
    emit(state.copyWith(isLoading: true));
    try {
      final TaskEntity task = TaskEntity(
        title: state.title?.trim() ?? '',
        note: state.note?.trim() ?? '',
        documents: await uploadFileToStorage(),
        date:
            DateTimeUtils.convertDateTimeToString(state.date ?? DateTime.now())
                .toString(),
        start: DateTimeUtils.convertTimeOfDayToString(
            state.startTime ?? TimeOfDay.now()),
        end: DateTimeUtils.convertTimeOfDayToString(
            state.endTime ?? TimeOfDay.now()),
        category: state.category ?? CategoryEntity(title: '', color: 0),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(GlobalData.instance.userID)
          .collection('tasks')
          .add(task.toJson())
          .then((value) async {
        Get.back(result: true);
      });
      AppSnackbar.showSuccess(
        title: S.current.task,
        message: S.current.added_successfully,
      );
    } on FirebaseAuthException catch (e) {
      AppSnackbar.showError(title: 'Firebase', message: e.message);
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<List<String>> uploadFileToStorage({TaskEntity? task}) async {
    final List<String> result = [];
    final List<String> list = [...?state.documentList];
    if ((task?.documents ?? []).isNotEmpty && list.isNotEmpty) {
      result.addAll(task!.documents!);
      result.map(
        (e) => list.remove(
          FileUtils.getFileNameFromUrl(e),
        ),
      );
    }
    if (list.isNotEmpty) {
      for (String item in list) {
        try {
          result.add(
            await FileUtils.uploadFile(
              file: File(item),
              userID: GlobalData.instance.userID ?? '',
              type: FileUtils.getDocumentType(item),
            ),
          );
        } catch (e) {
          logger.log(e);
        }
      }
    }
    return result;
  }
}
