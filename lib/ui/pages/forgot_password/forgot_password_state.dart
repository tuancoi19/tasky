part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? email;
  final String? code;

  const ForgotPasswordState(
      {this.loadDataStatus = LoadStatus.initial,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.email,
      this.code});

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        email,
        code,
      ];

  ForgotPasswordState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? email,
    String? code,
  }) {
    return ForgotPasswordState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      email: email ?? this.email,
      code: code ?? this.code,
    );
  }
}
