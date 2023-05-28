import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_date_time_picker.dart';

part 'task_screen_state.dart';

class TaskScreenCubit extends Cubit<TaskScreenState> {
  final AppCubit appCubit;

  TaskScreenCubit({required this.appCubit}) : super(const TaskScreenState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      changeCategoryList(
        categoryList: [
          CategoryEntity(color: 'FFF1EEAD', title: '12412'),
          CategoryEntity(color: 'FFA2F0E2', title: '23535'),
          CategoryEntity(color: 'FFCBADF1', title: '567658'),
          CategoryEntity(color: 'FFF4B6B6', title: '12412'),
          CategoryEntity(color: 'FFADF1E9', title: '23535'),
          CategoryEntity(color: 'FFADB8F1', title: '567658'),
          CategoryEntity(color: 'FF3DAE99', title: '12412'),
          CategoryEntity(color: 'FFBBB64F', title: '23535'),
          CategoryEntity(color: 'FFA46CEB', title: '567658'),
        ],
      );
      changeDocumentList(
        documentList: [
          'qwefwefkglkgregkerg/qwrqwrqwrqwrqt.jpg',
          'qwqwfqfefwgweg/qwdqwdfqwf.docx'
        ],
      );
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
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

  void changeCategoryList({required List<CategoryEntity> categoryList}) {
    emit(state.copyWith(categoryList: categoryList));
  }

  void changeCategory({required CategoryEntity category}) {
    emit(state.copyWith(category: category));
    changeThemeColor(colorCode: category.colorHex);
  }

  void changeDocumentList({required List<String> documentList}) {
    emit(state.copyWith(documentList: documentList));
  }

  void sendImage({required File file}) {
    final List<String> addedList = [...?state.documentList];
    addedList.add(file.uri.pathSegments.last);
    changeDocumentList(documentList: addedList);
  }

  void sendTextFile({required File file}) {
    final List<String> addedList = [...?state.documentList];
    addedList.add(file.uri.pathSegments.last);
    changeDocumentList(documentList: addedList);
  }

  void changeThemeColor({required int colorCode}) {
    emit(state.copyWith(themeColor: Color(colorCode)));
  }

  void setAutoValidateMode({required AutovalidateMode autoValidateMode}) {
    emit(state.copyWith(autoValidateMode: autoValidateMode));
  }

  void addTaskToFirebase() {
    emit(state.copyWith(isLoading: true));
    final bool checkDuration = (state.endTime ?? TimeOfDay.now()).hour >=
            (state.startTime ?? TimeOfDay.now()).hour &&
        (state.endTime ?? TimeOfDay.now()).minute >=
            (state.startTime ?? TimeOfDay.now()).minute;
    if (!checkDuration) {
    }
    /* ToDo else if () {} */
    else if (state.category == null) {
    } else {
      try {
        final TaskEntity task = TaskEntity(
          title: state.title ?? '',
          note: state.note ?? '',
          documents: state.documentList ?? [],
          date: AppDateTimePicker.convertDateTimeToString(
                  state.date ?? DateTime.now())
              .toString(),
          start: AppDateTimePicker.convertTimeOfDayToString(
              state.startTime ?? TimeOfDay.now()),
          end: AppDateTimePicker.convertTimeOfDayToString(
              state.endTime ?? TimeOfDay.now()),
          category: state.category ?? CategoryEntity(title: '', color: ''),
        );

        FirebaseFirestore.instance
            .collection('users')
            .doc(appCubit.currentUser?.uid)
            .collection('tasks')
            .doc(appCubit.currentUser?.uid)
            .set(task.toJson())
            .then((value) {});
      } catch (e) {
        print(e);
      }
    }
    emit(state.copyWith(isLoading: false));
  }
}
