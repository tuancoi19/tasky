part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? usernameOrEmail;
  final String? password;

  const LoginState({
    this.loadDataStatus = LoadStatus.initial,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.usernameOrEmail,
    this.password,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        usernameOrEmail,
        password,
      ];

  LoginState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? usernameOrEmail,
    String? password,
  }) {
    return LoginState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      usernameOrEmail: usernameOrEmail ?? this.usernameOrEmail,
      password: password ?? this.password,
    );
  }
}
