part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? usernameOrEmail;
  final String? email;
  final String? password;

  const SignupState({
    this.loadDataStatus = LoadStatus.initial,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.usernameOrEmail,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        usernameOrEmail,
        email,
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
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
