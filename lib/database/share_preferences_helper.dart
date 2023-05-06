import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/entities/user/app_user.dart';
import 'package:tasky/utils/logger.dart';

class SharedPreferencesHelper {
  static const _introKey = '_introKey';
  static const _keyAppUser = 'app_user';
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

  Future<AppUser> setLoggedInAt({
    DateTime? loggedInAt,
  }) async {
    final newAppUser = (await loadAppUser()).copyWith(
      loggedInAt: loggedInAt,
    );
    await _updateAppUser(newAppUser);
    return newAppUser;
  }

  Future<AppUser> setAppUser({
    AppUser? currentAppUser,
  }) async {
    final baseAppUser = currentAppUser ?? await loadAppUser();
    final newAppUser = baseAppUser;
    await _updateAppUser(newAppUser);
    return newAppUser;
  }

  Future<AppUser> loadAppUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_keyAppUser)) {
      return const AppUser();
    }
    final value = prefs.getString(_keyAppUser);
    final map = jsonDecode(value!) as Map<String, dynamic>;
    return AppUser.fromJson(map);
  }

  Future<void> _updateAppUser(AppUser appUser) async {
    final prefs = await SharedPreferences.getInstance();
    final value = jsonEncode(appUser.toJson());
    await prefs.setString(_keyAppUser, value);
  }
  
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyAppUser);
  }
}
