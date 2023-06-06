part of 'edit_user_profile_cubit.dart';

class EditUserProfileState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? imagePath;
  final AutovalidateMode autoValidateMode;
  final String? userName;
  final String? password;
  final bool isEditProfile;
  XFile? image;
  int? width;
  int? height;
  CroppedFile? imageCrop;

  EditUserProfileState({
    this.loadDataStatus = LoadStatus.initial,
    this.imagePath,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.userName,
    this.password,
    this.isEditProfile = false,
    this.width,
    this.height,
    this.imageCrop,
    this.image,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        imagePath,
        autoValidateMode,
        userName,
        password,
        isEditProfile,
        width,
        height,
        imageCrop,
        image,
      ];

  EditUserProfileState copyWith({
    LoadStatus? loadDataStatus,
    String? imagePath,
    AutovalidateMode? autoValidateMode,
    String? userName,
    String? password,
    bool? isEditProfile,
    XFile? image,
    int? width,
    int? height,
    CroppedFile? imageCrop,
  }) {
    return EditUserProfileState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      imagePath: imagePath ?? this.imagePath,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isEditProfile: isEditProfile ?? this.isEditProfile,
      image: image ?? this.image,
      width: width ?? this.width,
      height: height ?? this.height,
      imageCrop: imageCrop ?? this.imageCrop,
    );
  }
}
