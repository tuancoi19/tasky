part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final LoadStatus loadDataStatus;
  final int? selectedColor;
  final AutovalidateMode autoValidateMode;
  final String? name;

  const CategoryState({
    this.loadDataStatus = LoadStatus.initial,
    this.selectedColor,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.name,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        selectedColor,
        autoValidateMode,
        name,
      ];

  CategoryState copyWith({
    LoadStatus? loadDataStatus,
    int? selectedColor,
    AutovalidateMode? autoValidateMode,
    String? name,
  }) {
    return CategoryState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      selectedColor: selectedColor ?? this.selectedColor,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      name: name ?? this.name,
    );
  }
}
