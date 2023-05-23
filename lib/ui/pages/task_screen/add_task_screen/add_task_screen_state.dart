part of 'add_task_screen_cubit.dart';

class AddTaskScreenState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? title;
  final AutovalidateMode autoValidateMode;
  final String? startTime;
  final String? endTime;
  final String? date;
  final String? note;
  final List<CategoryEntity>? categoryList;
  final CategoryEntity? category;
  final List<String>? documentList;

  const AddTaskScreenState({
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
      ];

  AddTaskScreenState copyWith({
    LoadStatus? loadDataStatus,
    String? title,
    AutovalidateMode? autoValidateMode,
    String? startTime,
    String? endTime,
    String? date,
    String? note,
    List<CategoryEntity>? categoryList,
    CategoryEntity? category,
    List<String>? documentList,
  }) {
    return AddTaskScreenState(
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
    );
  }
}
