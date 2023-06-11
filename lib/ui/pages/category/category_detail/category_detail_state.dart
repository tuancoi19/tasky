part of 'category_detail_cubit.dart';

class CategoryDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<TaskEntity>? taskList;
  final CategoryEntity? category;
  final bool isLoading;
  final bool needReload;

  const CategoryDetailState({
    this.loadDataStatus = LoadStatus.initial,
    this.taskList,
    this.category,
    this.isLoading = false,
    this.needReload = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        taskList,
        category,
        isLoading,
        needReload,
      ];

  CategoryDetailState copyWith({
    LoadStatus? loadDataStatus,
    List<TaskEntity>? taskList,
    CategoryEntity? category,
    bool? isLoading,
    bool? needReload,
  }) {
    return CategoryDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      taskList: taskList ?? this.taskList,
      category: category ?? this.category,
      isLoading: isLoading ?? this.isLoading,
      needReload: needReload ?? this.needReload,
    );
  }
}
