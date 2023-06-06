part of 'add_category_cubit.dart';

class AddCategoryState extends Equatable {
  final LoadStatus loadDataStatus;
  final int? selectedColor;
  final AutovalidateMode autoValidateMode;
  final String? name;
  final bool isLoading;

  const AddCategoryState({
    this.loadDataStatus = LoadStatus.initial,
    this.selectedColor,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.name,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        selectedColor,
        autoValidateMode,
        name,
        isLoading,
      ];

  AddCategoryState copyWith({
    LoadStatus? loadDataStatus,
    int? selectedColor,
    AutovalidateMode? autoValidateMode,
    String? name,
    bool? isLoading,
  }) {
    return AddCategoryState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      selectedColor: selectedColor ?? this.selectedColor,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
