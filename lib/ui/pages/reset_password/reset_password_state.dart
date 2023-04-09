part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? newPassword;
  final String? repeatPassword;

  const ResetPasswordState({
    this.loadDataStatus = LoadStatus.initial,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.newPassword,
    this.repeatPassword,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        newPassword,
        repeatPassword,
      ];

  ResetPasswordState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? newPassword,
    String? repeatPassword,
  }) {
    return ResetPasswordState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      newPassword: newPassword ?? this.newPassword,
      repeatPassword: repeatPassword ?? this.repeatPassword,
    );
  }
}
