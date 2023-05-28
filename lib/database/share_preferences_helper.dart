import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/entities/user/user_entity.dart';
import 'package:tasky/utils/logger.dart';

class SharedPreferencesHelper {
  static const _introKey = '_introKey';
  static const _keyUser = 'app_user';
  static const _authKey = '_authKey';

  //Get authKey
  static Future<String> getApiTokenKey() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_authKey) ?? "";
    } catch (e) {
      logger.e(e);
      return "";
    }
  }

  //Set authKey
  static void setApiTokenKey(String apiTokenKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authKey, apiTokenKey);
  }

  static void removeApiTokenKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
  }

  //Get intro
  static Future<bool> isSeenIntro() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_introKey) ?? false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  //Set intro
  static void setSeenIntro({isSeen = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_introKey, isSeen ?? true);
  }

  Future<UserEntity> setLoggedInAt({
    DateTime? loggedInAt,
  }) async {
    final newUserEntity = await loadUserEntity();
    newUserEntity.loggedInAt = loggedInAt;
    await _updateUserEntity(newUserEntity);
    return newUserEntity;
  }

  Future<UserEntity> setUserEntity({
    UserEntity? currentUserEntity,
  }) async {
    final baseUserEntity = currentUserEntity ?? await loadUserEntity();
    final newUserEntity = baseUserEntity;
    await _updateUserEntity(newUserEntity);
    return newUserEntity;
  }

  Future<UserEntity> loadUserEntity() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_keyUser)) {
      return UserEntity();
    }
    final value = prefs.getString(_keyUser);
    final map = jsonDecode(value!) as Map<String, dynamic>;
    return UserEntity.fromJson(map);
  }

  Future<void> _updateUserEntity(UserEntity UserEntity) async {
    final prefs = await SharedPreferences.getInstance();
    final value = jsonEncode(UserEntity.toJson());
    await prefs.setString(_keyUser, value);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}
