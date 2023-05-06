part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final LoadStatus loadDataStatus;

  const AuthenticationState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  AuthenticationState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? usernameOrEmail,
    String? password,
  }) {
    return AuthenticationState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
