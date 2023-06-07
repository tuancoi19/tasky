part of 'edit_user_profile_cubit.dart';

class EditUserProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final AutovalidateMode autoValidateMode;
  final String? userName;
  final String? password;
  final bool isEditProfile;
  final XFile? image;
  final CroppedFile? imageCrop;
  final bool clearImg;

  const EditUserProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.userName,
    this.password,
    this.isEditProfile = false,
    this.imageCrop,
    this.image,
    this.clearImg = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        autoValidateMode,
        userName,
        password,
        isEditProfile,
        imageCrop,
        image,
        clearImg,
      ];

  EditUserProfileState copyWith({
    LoadStatus? loadDataStatus,
    AutovalidateMode? autoValidateMode,
    String? userName,
    String? password,
    bool? isEditProfile,
    XFile? image,
    CroppedFile? imageCrop,
    bool clearImg = false,
  }) {
    return EditUserProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isEditProfile: isEditProfile ?? this.isEditProfile,
      image: clearImg == true ? null : image ?? this.image,
      imageCrop: clearImg == true ? null : imageCrop ?? this.imageCrop,
    );
  }
}
