part of 'search_cubit.dart';

class SearchState extends Equatable {
  final bool isLoading;
  final List<TaskEntity>? taskList;

  const SearchState({
    this.isLoading = false,
    this.taskList,
  });

  @override
  List<Object?> get props => [
        isLoading,
        taskList,
      ];

  SearchState copyWith({
    bool? isLoading,
    List<TaskEntity>? taskList,
    String? keyword,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      taskList: taskList ?? this.taskList,
    );
  }
}
