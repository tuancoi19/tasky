part of 'category_detail_cubit.dart';

class CategoryDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<TaskEntity>? taskList;
  final CategoryEntity? category;
  final bool isLoading;

  const CategoryDetailState({
    this.loadDataStatus = LoadStatus.initial,
    this.taskList,
    this.category,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        taskList,
        category,
        isLoading,
      ];

  CategoryDetailState copyWith({
    LoadStatus? loadDataStatus,
    List<TaskEntity>? taskList,
    CategoryEntity? category,
    bool? isLoading,
  }) {
    return CategoryDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      taskList: taskList ?? this.taskList,
      category: category ?? this.category,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
