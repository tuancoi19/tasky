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

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeScreenCubit homeScreenCubit;

  CategoryCubit({
    required this.homeScreenCubit,
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

  Future<CategoryEntity?> addCategoryToFirebase() async {
    emit(state.copyWith(isLoading: true));
    try {
      CategoryEntity? category;
      if (state.name != null &&
          state.selectedColor != null &&
          (state.name ?? '').isNotEmpty) {
        category = CategoryEntity(
          title: state.name ?? '',
          color: state.selectedColor ?? 0,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(GlobalData.instance.userID)
            .collection('categories')
            .add(category.toJson())
            .then((value) async {
          await homeScreenCubit.getCategoriesList();
        });
      }
      emit(state.copyWith(isLoading: false));
    } on FirebaseAuthException catch (e) {
      AppSnackbar.showError(
        title: 'Firebase',
        message: e.message,
      );
    }
    return null;
  }
}
