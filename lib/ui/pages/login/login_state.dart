part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus loadDataStatus;

  const LoginState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  LoginState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return LoginState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
