import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final AppCubit appCubit;

  HomeScreenCubit(this.appCubit) : super(const HomeScreenState());

  Future<void> loadInitialData() async {
    await getTasksList();
    await getCategoriesList();
  }

  Future<void> getTasksList() async {
    emit(state.copyWith(loadTasksListStatus: LoadStatus.loading));
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(appCubit.currentUser?.uid)
          .collection('tasks')
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return TaskEntity.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
      if (result.isNotEmpty) {
        GlobalData.instance.tasksList = result;
        emit(state.copyWith(tasksList: result));
      }
      emit(state.copyWith(loadTasksListStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadTasksListStatus: LoadStatus.failure));
    }
  }

  Future<void> getCategoriesList() async {
    emit(state.copyWith(loadCategoriesListStatus: LoadStatus.loading));
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(appCubit.currentUser?.uid)
          .collection('categories')
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return CategoryEntity.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
      if (result.isNotEmpty) {
        GlobalData.instance.categoriesList = result;
        emit(state.copyWith(categoriesList: result));
      }
      emit(state.copyWith(loadCategoriesListStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadCategoriesListStatus: LoadStatus.failure));
    }
  }
}
