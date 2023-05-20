part of 'detail_task_screen_cubit.dart';

class DetailTaskScreenState extends Equatable {
  final LoadStatus loadDataStatus;

  const DetailTaskScreenState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  DetailTaskScreenState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return DetailTaskScreenState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
