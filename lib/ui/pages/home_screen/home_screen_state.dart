part of 'home_screen_cubit.dart';

class HomeScreenState extends Equatable {
  final LoadStatus loadCategoriesListStatus;
  final LoadStatus loadTasksListStatus;
  final List<TaskEntity>? tasksList;
  final List<CategoryEntity>? categoriesList;

  const HomeScreenState({
    this.loadCategoriesListStatus = LoadStatus.initial,
    this.loadTasksListStatus = LoadStatus.initial,
    this.tasksList,
    this.categoriesList,
  });

  @override
  List<Object?> get props => [
        loadCategoriesListStatus,
        loadTasksListStatus,
        tasksList,
        categoriesList,
      ];

  HomeScreenState copyWith({
    LoadStatus? loadCategoriesListStatus,
    LoadStatus? loadTasksListStatus,
    List<TaskEntity>? tasksList,
    List<CategoryEntity>? categoriesList,
  }) {
    return HomeScreenState(
      loadCategoriesListStatus:
          loadCategoriesListStatus ?? this.loadCategoriesListStatus,
      loadTasksListStatus: loadTasksListStatus ?? this.loadTasksListStatus,
      tasksList: tasksList ?? this.tasksList,
      categoriesList: categoriesList ?? this.categoriesList,
    );
  }
}
