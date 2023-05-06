import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/models/enums/load_status.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(const UserProfileState());

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

  void changeIsNotify({required isNotify}) {
    emit(state.copyWith(isNotify: isNotify));
  }
}
