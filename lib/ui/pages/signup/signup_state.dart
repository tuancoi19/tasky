part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? usernameOrEmail;
  final String? confirmPassword;
  final String? password;

  const SignupState({
    this.loadDataStatus = LoadStatus.initial,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.usernameOrEmail,
    this.confirmPassword,
    this.password,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        usernameOrEmail,
        confirmPassword,
        password,
      ];

  SignupState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? usernameOrEmail,
    String? email,
    String? password,
  }) {
    return SignupState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      usernameOrEmail: usernameOrEmail ?? this.usernameOrEmail,
      confirmPassword: confirmPassword ?? confirmPassword,
      password: password ?? this.password,
    );
  }
}
