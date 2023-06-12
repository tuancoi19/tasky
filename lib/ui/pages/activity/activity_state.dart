part of 'activity_cubit.dart';

class ActivityState extends Equatable {
  final LoadStatus loadDataStatus;
  final CalendarView type;
  final List<Appointment>? tasksData;
  final bool needReload;

  const ActivityState({
    this.loadDataStatus = LoadStatus.initial,
    this.type = CalendarView.day,
    this.tasksData,
    this.needReload = false,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        type,
        tasksData,
        needReload,
      ];

  ActivityState copyWith({
    LoadStatus? loadDataStatus,
    CalendarView? type,
    List<Appointment>? tasksData,
    bool? needReload,
  }) {
    return ActivityState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      type: type ?? this.type,
      tasksData: tasksData ?? this.tasksData,
      needReload: needReload ?? this.needReload,
    );
  }
}
