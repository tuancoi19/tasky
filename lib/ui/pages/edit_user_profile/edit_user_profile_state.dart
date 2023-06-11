part of 'edit_user_profile_cubit.dart';

class EditUserProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? userName;
  final String? password;
  final bool isEditProfile;
  final CroppedFile? imageCrop;
  final bool isClear;

  const EditUserProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.userName,
    this.password,
    this.isEditProfile = false,
    this.imageCrop,
    this.isClear = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        userName,
        password,
        isEditProfile,
        imageCrop,
        isClear,
      ];

  EditUserProfileState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? userName,
    String? password,
    bool? isEditProfile,
    XFile? image,
    CroppedFile? imageCrop,
    bool isClear = false,
  }) {
    return EditUserProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      userName: isClear == true ? null : userName ?? this.userName,
      password: password ?? this.password,
      isEditProfile: isEditProfile ?? this.isEditProfile,
      imageCrop: isClear == true ? null : imageCrop ?? this.imageCrop,
    );
  }
}
