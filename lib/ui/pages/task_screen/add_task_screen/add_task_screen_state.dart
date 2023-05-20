part of 'add_task_screen_cubit.dart';

class AddTaskScreenState extends Equatable {
  final LoadStatus loadDataStatus;

  const AddTaskScreenState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  AddTaskScreenState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return AddTaskScreenState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
