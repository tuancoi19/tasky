import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());

  void setLoading(LoadStatus loadStatus) {
    emit(state.copyWith(loadDataStatus: loadStatus));
  }

  void setCurentPage(int currentPage) {
    emit(state.copyWith(currentPage: currentPage));
  }
}
