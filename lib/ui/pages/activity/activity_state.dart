part of 'activity_cubit.dart';

class ActivityState extends Equatable {
  final LoadStatus loadDataStatus;

  const ActivityState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  ActivityState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return ActivityState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
