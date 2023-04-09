import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(const ResetPasswordState());

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

  void changeNewPassword({required String newPassword}) {
    emit(state.copyWith(newPassword: newPassword));
  }

  void changeRepeatPassword({required String repeatPassword}) {
    emit(state.copyWith(repeatPassword: repeatPassword));
  }

  void onValidateForm() {
    emit(state.copyWith(autoValidateMode: AutovalidateMode.onUserInteraction));
  }
}
