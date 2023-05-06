part of 'notification_screen_cubit.dart';

class NotificationScreenState extends Equatable {
  final LoadStatus loadDataStatus;

  const NotificationScreenState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  NotificationScreenState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return NotificationScreenState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
