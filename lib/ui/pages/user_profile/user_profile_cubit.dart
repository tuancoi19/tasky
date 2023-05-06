import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/utils/auth.dart';
import 'package:tasky/utils/logger.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({
    required this.appCubit,
  }) : super(const UserProfileState());
  final AppCubit appCubit;

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

  Future<void> signOut({
    required void Function() onSignOutSuccessful,
    required void Function() onSignOutFailed,
  }) async {
   
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      appCubit.signOut();
      await Auth().signOut();
      emit(state.copyWith(loadDataStatus: LoadStatus.success));

      onSignOutSuccessful();
    } on FirebaseAuthException catch (e) {
      logger.e(e.message ?? '');
      onSignOutFailed();
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    }
  }
}
