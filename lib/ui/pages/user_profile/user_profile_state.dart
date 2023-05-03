part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final bool isNotify;

  const UserProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.isNotify = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        isNotify,
      ];

  UserProfileState copyWith({
    LoadStatus? loadDataStatus,
    bool? isNotify,
  }) {
    return UserProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      isNotify: isNotify ?? this.isNotify,
    );
  }
}
