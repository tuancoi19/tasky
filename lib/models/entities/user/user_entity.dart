import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

//
// @freezed
// abstract class AppUser with _$AppUser {
//   const factory AppUser({
//     @Default(false) bool isUserLoggedIn,
//     String? userId,
//     String? fcmToken,
//     String? fullName,
//     String? avatarUrl,
//     DateTime? loggedInAt,
//   }) = _AppUser;
//
//   factory AppUser.fromJson(Map<String, dynamic> json) =>
//       _$AppUserFromJson(json);
//
//   factory AppUser.mockData() {
//     return const AppUser(
//       userId: '12345678',
//       fullName: "Newwave",
//       avatarUrl: "https://i.imgur.com/geqAiJG.jpg",
//     );
//   }
// }

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class UserEntity {
  @JsonKey(name: 'user_id')
  String? userId;

  @JsonKey(name: 'fcm_token')
  String? fcmToken;

  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  @JsonKey(name: 'logged_in_at')
  @TimestampConverter()
  DateTime? loggedInAt;

  @JsonKey(name: 'is_logged_in')
  bool isLoggedIn;

  @JsonKey()
  String? email;

  @JsonKey(name: 'create_at')
  @TimestampConverter()
  DateTime? createAt;

  UserEntity({
    this.userId,
    this.fcmToken,
    this.userName,
    this.avatarUrl,
    this.loggedInAt,
    this.isLoggedIn = false,
    this.email,
    this.createAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

// class UserEntity {
//   String? userId;
//   String? email;
//   String? fcmToken;
//   String? userName;
//   String? avatarUrl;
//   DateTime? loggedInAt;
//   DateTime? createAt;
//   bool isLoggedIn;
//
//   UserEntity({
//     this.userId,
//     this.email,
//     this.fcmToken,
//     this.userName,
//     this.avatarUrl,
//     this.loggedInAt,
//     this.createAt,
//     this.isLoggedIn = false,
//   });
