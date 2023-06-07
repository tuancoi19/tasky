import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/entities/task/task_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';

part 'category_detail_state.dart';

class CategoryDetailCubit extends Cubit<CategoryDetailState> {
  CategoryDetailCubit() : super(const CategoryDetailState());

  Future<void> loadInitialData(CategoryEntity? category) async {
    emit(state.copyWith(category: category));
    await getTaskList();
  }

  Future<void> getTaskList() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(GlobalData.instance.userID)
          .collection('tasks')
          .where('categoryId', isEqualTo: state.category?.id)
          .get()
          .then((QuerySnapshot querySnapshot) {
        return querySnapshot.docs.map((doc) {
          final TaskEntity result =
              TaskEntity.fromJson(doc.data() as Map<String, dynamic>);
          result.id = doc.id;
          return result;
        }).toList();
      });
      if (result.isNotEmpty) {
        result.sort(
          (a, b) {
            int dateComparison = (a.date ?? '').compareTo((b.date ?? ''));
            if (dateComparison != 0) {
              return dateComparison;
            }
            return (a.start ?? '').compareTo((b.start ?? ''));
          },
        );
        emit(state.copyWith(taskList: result));
      }
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
      AppSnackbar.showError(
        title: 'Firebase',
        message: e.message,
      );
    }
  }

  Future<void> deleteCategoryOnFirebase() async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(GlobalData.instance.userID)
          .collection('categories')
          .doc(state.category?.id)
          .delete();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(GlobalData.instance.userID)
          .collection('tasks')
          .where('categoryId', isEqualTo: state.category?.id)
          .get()
          .then((QuerySnapshot querySnapshot) async {
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
      });
      Get.back(result: true, closeOverlays: true);
      AppSnackbar.showSuccess(
        title: S.current.category,
        message: S.current.deleted_successfully,
      );
    } on FirebaseAuthException catch (e) {
      AppSnackbar.showError(title: 'Firebase', message: e.message);
    }
    emit(state.copyWith(isLoading: false));
  }
}
