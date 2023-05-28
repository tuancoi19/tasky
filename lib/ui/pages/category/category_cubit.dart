import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(const CategoryState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  void changeSelectedColor({required Color selectedColor}) {
    emit(state.copyWith(selectedColor: selectedColor));
  }

  void changeAutoValidateMode({required AutovalidateMode autoValidateMode}) {
    emit(state.copyWith(autoValidateMode: autoValidateMode));
  }
}
