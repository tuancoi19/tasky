part of 'edit_user_profile_cubit.dart';

class EditUserProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? imagePath;
  final AutovalidateMode autoValidateMode;
  final String? displayName;
  final String? password;

  const EditUserProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.imagePath,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.displayName,
    this.password,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        imagePath,
        autoValidateMode,
        displayName,
        password,
      ];

  EditUserProfileState copyWith({
    LoadStatus? loadDataStatus,
    String? imagePath,
    AutovalidateMode? autoValidateMode,
    String? displayName,
    String? password,
  }) {
    return EditUserProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      imagePath: imagePath ?? this.imagePath,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      displayName: displayName ?? this.displayName,
      password: password ?? this.password,
    );
  }
}
