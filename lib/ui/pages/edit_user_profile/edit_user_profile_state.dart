part of 'edit_user_profile_cubit.dart';

class EditUserProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? imagePath;
  final AutovalidateMode autoValidateMode;
  final String? firstName;
  final String? lastName;

  const EditUserProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.imagePath,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.firstName,
    this.lastName,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        imagePath,
        autoValidateMode,
        firstName,
        lastName,
      ];

  EditUserProfileState copyWith({
    LoadStatus? loadDataStatus,
    String? imagePath,
    AutovalidateMode? autoValidateMode,
    String? firstName,
    String? lastName,
  }) {
    return EditUserProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      imagePath: imagePath ?? this.imagePath,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
