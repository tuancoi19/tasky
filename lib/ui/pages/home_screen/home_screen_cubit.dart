import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';
import 'package:tasky/utils/task_date_utils.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(const HomeScreenState());

  Future<void> loadInitialData() async {
    await getCategoriesList();
    await getTasksList();
    await getCategoriesList();
  }

  Future<void> getTasksList() async {
    emit(state.copyWith(loadTasksListStatus: LoadStatus.loading));
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
      List<TaskEntity>? todayTaskList;
      if (result.isNotEmpty) {
        todayTaskList = TaskDateUtils.filterItemsByDate(
          date: DateTime.now(),
          items: result,
        );
        todayTaskList.sort(
          (a, b) => (a.start ?? '').compareTo(b.start ?? ''),
        );
      }
      GlobalData.instance.tasksList = result;
      emit(
        state.copyWith(
          tasksList: todayTaskList ?? [],
        ),
      );
      emit(state.copyWith(loadTasksListStatus: LoadStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loadTasksListStatus: LoadStatus.failure));
      AppSnackbar.showError(
        title: 'Firebase',
        message: e.message,
      );
    }
  }

  Future<void> getCategoriesList() async {
    emit(state.copyWith(loadCategoriesListStatus: LoadStatus.loading));
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(GlobalData.instance.userID)
          .collection('categories')
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final CategoryEntity result =
              CategoryEntity.fromJson(doc.data() as Map<String, dynamic>);
          result.id = doc.id;
          return result;
        }).toList();
      });
      if (result.isNotEmpty) {
        result.sort(
          (a, b) => (a.title ?? '').compareTo(b.title ?? ''),
        );
      }
      GlobalData.instance.categoriesList = result;
      emit(state.copyWith(categoriesList: result));
      emit(state.copyWith(loadCategoriesListStatus: LoadStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loadTasksListStatus: LoadStatus.failure));
      AppSnackbar.showError(
        title: 'Firebase',
        message: e.message,
      );
    }
  }
}
