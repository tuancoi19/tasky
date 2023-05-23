part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? email;
  final String? userName;
  final String? confirmPassword;
  final String? password;

  const SignupState({
    this.loadDataStatus = LoadStatus.initial,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.email,
    this.userName,
    this.confirmPassword,
    this.password,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        email,
        userName,
        confirmPassword,
        password,
      ];

  SignupState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? userName,
    String? email,
    String? password,
  }) {
    return SignupState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      confirmPassword: confirmPassword ?? confirmPassword,
      password: password ?? this.password,
    );
  }
}
