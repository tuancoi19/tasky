import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    @Default(false) bool isUserLoggedIn,
    String? userId,
    String? fcmToken,
    String? fullName,
    String? avatarUrl,
    DateTime? loggedInAt,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.mockData() {
    return const AppUser(
      userId: '12345678',
      fullName: "Newwave",
      avatarUrl: "https://i.imgur.com/geqAiJG.jpg",
    );
  }
}
