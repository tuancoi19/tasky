import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final AppCubit appCubit;

  CategoryCubit({
    required this.appCubit,
  }) : super(const CategoryState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void changeSelectedColor({required int selectedColor}) {
    emit(state.copyWith(selectedColor: selectedColor));
  }

  void changeAutoValidateMode({required AutovalidateMode autoValidateMode}) {
    emit(state.copyWith(autoValidateMode: autoValidateMode));
  }

  void changeName({required String name}) {
    emit(state.copyWith(name: name));
  }

  Future<void> addCategoryToFirebase() async {
    if (state.name != null &&
        state.selectedColor != null &&
        (state.name ?? '').isNotEmpty) {
      final CategoryEntity category = CategoryEntity(
        title: state.name ?? '',
        color: state.selectedColor ?? 0,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(appCubit.currentUser?.uid)
          .collection('categories')
          .add(category.toJson())
          .then((value) {});
    }
  }
}
