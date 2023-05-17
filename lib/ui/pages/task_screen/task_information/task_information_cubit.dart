import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'task_information_state.dart';

class TaskInformationCubit extends Cubit<TaskInformationState> {
  TaskInformationCubit() : super(const TaskInformationState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void changeTitle({required String title}) {
    emit(state.copyWith(title: title));
  }

  void changeStartTime({required String startTime}) {
    emit(state.copyWith(startTime: startTime));
  }

  void changeEndTime({required String endTime}) {
    emit(state.copyWith(endTime: endTime));
  }

  void changeDate({required String date}) {
    emit(state.copyWith(date: date));
  }

  void changeNote({required String note}) {
    emit(state.copyWith(note: note));
  }
}
