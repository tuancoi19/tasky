import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

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

  void forgotPassword() {
    emit(state.copyWith(isVerification: true));
  }

  void onValidateForm() {
    emit(
      state.copyWith(
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  void changeUsernameOrEmail({required String usernameOrEmail}) {
    emit(
      state.copyWith(usernameOrEmail: usernameOrEmail),
    );
  }

  void changeCode({required String code}) {
    emit(
      state.copyWith(code: code),
    );
  }
}
