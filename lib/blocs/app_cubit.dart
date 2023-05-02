import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/database/secure_storage_helper.dart';
import 'package:tasky/database/share_preferences_helper.dart';
import 'package:tasky/models/entities/token_entity.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/models/enums/load_status.dart';
import 'package:tasky/repositories/auth_repository.dart';
import 'package:tasky/repositories/user_repository.dart';
import 'package:tasky/utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.userRepo,
    required this.authRepo,
  }) : super(const AppState());

  void fetchProfile() {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  void updateProfile(AppUser user) {
    emit(state.copyWith(user: user));
  }

  Future<bool> saveSession({
    String? token,
    String refreshToken = '',
    AppUser? currentAppUser,
  }) async {
    await _saveToSecureStorage(token: token ?? '', refreshToken: refreshToken);
    await _saveToSharedPreferences(currentAppUser);

    return true;
  }

  Future<void> _saveToSecureStorage(
      {String token = '', String refreshToken = ''}) async {
    final tokenEntity =
        TokenEntity(accessToken: token, refreshToken: refreshToken);
    final secureStorageHelper = SecureStorageHelper.instance;

    secureStorageHelper.removeToken();
    secureStorageHelper.saveToken(tokenEntity);
  }

  Future<void> _saveToSharedPreferences(
    AppUser? currentAppUser,
  ) async {
    final sharedPreferencesHelper = SharedPreferencesHelper();
    await sharedPreferencesHelper.setAppUser(
      currentAppUser: currentAppUser,
    );
  }

  ///Sign Out
  void signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final sharedPreferencesHelper = SharedPreferencesHelper();
      final secureStorageHelper = SecureStorageHelper.instance;

      secureStorageHelper.removeToken();
      await sharedPreferencesHelper.logout();
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }
}
