import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/entities/category/category_entity.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'add_task_screen_state.dart';

class AddTaskScreenCubit extends Cubit<AddTaskScreenState> {
  AddTaskScreenCubit() : super(const AddTaskScreenState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      changeCategoryList(
        categoryList: [
          CategoryEntity(color: 0xFFF1EEAD, title: '12412'),
          CategoryEntity(color: 0xFFA2F0E2, title: '23535'),
          CategoryEntity(color: 0xFFCBADF1, title: '567658'),
          CategoryEntity(color: 0xFFF4B6B6, title: '12412'),
          CategoryEntity(color: 0xFFADF1E9, title: '23535'),
          CategoryEntity(color: 0xFFADB8F1, title: '567658'),
          CategoryEntity(color: 0xFF3DAE99, title: '12412'),
          CategoryEntity(color: 0xFFBBB64F, title: '23535'),
          CategoryEntity(color: 0xFFA46CEB, title: '567658'),
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

  void changeCategoryList({required List<CategoryEntity> categoryList}) {
    emit(state.copyWith(categoryList: categoryList));
  }

  void changeCategory({required CategoryEntity category}) {
    emit(state.copyWith(category: category));
  }

  void changeDocumentList({required List<String> documentList}) {
    emit(state.copyWith(documentList: documentList));
  }
}
