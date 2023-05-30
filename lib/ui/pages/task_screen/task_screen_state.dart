part of 'task_screen_cubit.dart';

class TaskScreenState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? title;
  final AutovalidateMode autoValidateMode;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final DateTime? date;
  final String? note;
  final List<CategoryEntity>? categoryList;
  final CategoryEntity? category;
  final List<String>? documentList;
  final Color themeColor;
  final bool isLoading;

  const TaskScreenState({
    this.loadDataStatus = LoadStatus.initial,
    this.title,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.startTime,
    this.endTime,
    this.date,
    this.note,
    this.categoryList,
    this.category,
    this.documentList,
    this.themeColor = AppColors.primary,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        title,
        autoValidateMode,
        startTime,
        endTime,
        date,
        note,
        categoryList,
        category,
        documentList,
        themeColor,
        isLoading,
      ];

  TaskScreenState copyWith({
    LoadStatus? loadDataStatus,
    String? title,
    AutovalidateMode? autoValidateMode,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    DateTime? date,
    String? note,
    List<CategoryEntity>? categoryList,
    CategoryEntity? category,
    List<String>? documentList,
    Color? themeColor,
    bool? isLoading,
  }) {
    return TaskScreenState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      title: title ?? this.title,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
      note: note ?? this.note,
      categoryList: categoryList ?? this.categoryList,
      category: category ?? this.category,
      documentList: documentList ?? this.documentList,
      themeColor: themeColor ?? this.themeColor,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
