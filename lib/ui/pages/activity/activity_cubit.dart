import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit() : super(const ActivityState());

  Future<void> loadInitialData() async {
    await getTasksList();
  }

  void changeType({required CalendarView type}) {
    emit(state.copyWith(type: type));
  }

  void setNeedReload({required bool needReload}) {
    emit(state.copyWith(needReload: needReload));
  }

  Future<void> getTasksList() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(GlobalData.instance.userID)
          .collection('tasks')
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final TaskEntity result =
              TaskEntity.fromJson(doc.data() as Map<String, dynamic>);
          result.id = doc.id;
          return result;
        }).toList();
      });

      GlobalData.instance.tasksList = result;
      List<Appointment> tasks = GlobalData.instance.tasksList
          .map(
            (e) => Appointment(
              startTime: e.startToDateTime ?? DateTime.now(),
              endTime: e.endToDateTime ?? DateTime.now(),
              notes: e.note,
              subject: e.title ?? '',
              color: Color(e.category?.color ?? 0),
              id: e.id,
            ),
          )
          .toList();
      emit(
        state.copyWith(
          tasksData: tasks,
        ),
      );

      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
      AppSnackbar.showError(
        title: 'Firebase',
        message: e.message,
      );
    }
  }
}
