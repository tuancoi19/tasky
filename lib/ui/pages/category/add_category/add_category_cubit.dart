import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/global/global_data.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/ui/commons/app_snackbar.dart';
import 'package:tasky/ui/pages/home_screen/home_screen_cubit.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  final HomeScreenCubit homeScreenCubit;

  AddCategoryCubit({
    required this.homeScreenCubit,
  }) : super(const AddCategoryState());

  Future<void> loadInitialData(CategoryEntity? category) async {
    if (category != null) {
      emit(state.copyWith(
        name: category.title,
        selectedColor: category.color,
      ));
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

  Future<CategoryEntity?> addCategoryToFirebase() async {
    emit(state.copyWith(isLoading: true));

    CategoryEntity? category;
    if (state.name != null &&
        state.selectedColor != null &&
        (state.name ?? '').isNotEmpty) {
      category = CategoryEntity(
        title: state.name ?? '',
        color: state.selectedColor ?? 0,
      );
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(GlobalData.instance.userID)
            .collection('categories')
            .add(category.toJson())
            .then((value) async {
          category?.id = value.id;
          await homeScreenCubit.getCategoriesList();
        });
      } on FirebaseAuthException catch (e) {
        AppSnackbar.showError(
          title: 'Firebase',
          message: e.message,
        );
      }
    }
    emit(state.copyWith(isLoading: false));
    return category;
  }

  Future<CategoryEntity?> updateCategoryOnFirebase(
      CategoryEntity initialCategory) async {
    emit(state.copyWith(isLoading: true));
    CategoryEntity? category;
    if (state.name != null &&
        state.selectedColor != null &&
        (state.name ?? '').isNotEmpty) {
      category = CategoryEntity(
        title: state.name ?? '',
        color: state.selectedColor ?? 0,
      );
      category.id = initialCategory.id;
      if (category != initialCategory) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(GlobalData.instance.userID)
              .collection('categories')
              .doc(initialCategory.id)
              .update(category.toJson())
              .then((value) async {
            await homeScreenCubit.loadInitialData();
          });
        } on FirebaseAuthException catch (e) {
          AppSnackbar.showError(
            title: 'Firebase',
            message: e.message,
          );
        }
      }
    }
    emit(state.copyWith(isLoading: false));
    return category;
  }
}
