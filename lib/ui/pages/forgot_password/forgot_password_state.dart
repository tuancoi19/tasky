part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final LoadStatus loadDataStatus;
  final bool isVerification;
  final AutovalidateMode autoValidateMode;
  final String? usernameOrEmail;
  final String? code;

  const ForgotPasswordState(
      {this.loadDataStatus = LoadStatus.initial,
      this.isVerification = false,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.usernameOrEmail,
      this.code});

  @override
  List<Object?> get props => [
        loadDataStatus,
        isVerification,
        autoValidateMode,
        usernameOrEmail,
        code,
      ];

  ForgotPasswordState copyWith({
    LoadStatus? loadDataStatus,
    bool? isVerification,
    AutovalidateMode? autoValidateMode,
    String? usernameOrEmail,
    String? code,
  }) {
    return ForgotPasswordState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      isVerification: isVerification ?? this.isVerification,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      usernameOrEmail: usernameOrEmail ?? this.usernameOrEmail,
      code: code ?? this.code,
    );
  }
}
