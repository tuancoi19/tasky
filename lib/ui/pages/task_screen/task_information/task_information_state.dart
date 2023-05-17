part of 'task_information_cubit.dart';

class TaskInformationState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? title;
  final AutovalidateMode autoValidateMode;
  final String? startTime;
  final String? endTime;

  const TaskInformationState({
    this.loadDataStatus = LoadStatus.initial,
    this.title,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.startTime,
    this.endTime,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        title,
        autoValidateMode,
        startTime,
        endTime,
      ];

  TaskInformationState copyWith({
    LoadStatus? loadDataStatus,
    String? title,
    AutovalidateMode? autoValidateMode,
    String? startTime,
    String? endTime,
  }) {
    return TaskInformationState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      title: title ?? this.title,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
