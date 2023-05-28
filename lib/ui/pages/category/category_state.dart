part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final LoadStatus loadDataStatus;
  final Color? selectedColor;
  final AutovalidateMode autoValidateMode;

  const CategoryState({
    this.loadDataStatus = LoadStatus.initial,
    this.selectedColor,
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        selectedColor,
        autoValidateMode,
      ];

  CategoryState copyWith({
    LoadStatus? loadDataStatus,
    Color? selectedColor,
    AutovalidateMode? autoValidateMode,
  }) {
    return CategoryState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      selectedColor: selectedColor ?? this.selectedColor,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }
}
