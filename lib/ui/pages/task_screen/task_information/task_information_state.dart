part of 'task_information_cubit.dart';

class TaskInformationState extends Equatable {
  final LoadStatus loadDataStatus;
  final String? title;
  final AutovalidateMode autoValidateMode;
  final String? startTime;
  final String? endTime;
  final String? date;
  final String? note;

  const TaskInformationState({
    this.loadDataStatus = LoadStatus.initial,
    this.title,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.startTime,
    this.endTime,
    this.date,
    this.note,
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
      ];

  TaskInformationState copyWith({
    LoadStatus? loadDataStatus,
    String? title,
    AutovalidateMode? autoValidateMode,
    String? startTime,
    String? endTime,
    String? date,
    String? note,
  }) {
    return TaskInformationState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      title: title ?? this.title,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }
}
